//
//  MQTTSubscriber.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 14/09/2023.
//  Responsible for subscribing and publishing to the MQTT broker
//  Using CocoaMQTT

import CocoaMQTT

class MQTTManager {
    
    let mqtt = CocoaMQTT(clientID: "iPad", host: "raspberrypi.local", port: 1883)
    
    init() {
        configureMQTT()
    }
    
    func configureMQTT() {
        // Configure connection and message handlers here
        mqtt.logLevel = .debug
        mqtt.username = "iPad"
        mqtt.password = "Apple!"
        let message = "will dieout"
        let payload: [UInt8] = Array(message.utf8)
        mqtt.willMessage = CocoaMQTTMessage(topic: "messagesFromiPad", payload: payload)
        mqtt.keepAlive = 60
        mqtt.autoReconnect = true
        mqtt.autoReconnectTimeInterval = 5
        mqtt.delegate = self
    }
    
    func connect() {
        let result = mqtt.connect()
        print("Connection was successful? \(result)")
    }
    
    func subscribe(toTopic topic: String) {
        mqtt.subscribe(topic)
        print("Subscribed to topic: \(topic)")
    }
    
    func publish(topic: String, content: String) {
        let array : [UInt8] = Array(content.utf8)
        let message = CocoaMQTTMessage(topic: topic, payload: array, qos: CocoaMQTTQoS.qos2, retained: true)
        mqtt.publish(message)
    }
}
    
extension MQTTManager: CocoaMQTTDelegate {
    func mqttUrlSession(_ mqtt: CocoaMQTT, didReceiveTrust trust: SecTrust, didReceiveChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            let myCert = "myCert"
            let certData = Data(base64Encoded: myCert as String)!

            if let trust = challenge.protectionSpace.serverTrust,
               let cert = SecCertificateCreateWithData(nil,  certData as CFData) {
                let certs = [cert]
                SecTrustSetAnchorCertificates(trust, certs as CFArray)

                completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: trust))
                return
            }
        }

        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)

    }


    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        TRACE("ack: \(ack)")
        func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
            switch ack {
            case .accept:
                print("Connection accepted. You are now connected to the broker.")
                mqtt.subscribe("messagesforiPad", qos: CocoaMQTTQoS.qos1)
            case .unacceptableProtocolVersion:
                print("Connection refused: Unacceptable protocol version")
                // Handle the error appropriately.
            case .identifierRejected:
                print("Connection refused: Identifier rejected")
                // Handle the error appropriately.
            case .serverUnavailable:
                print("Connection refused: Server unavailable")
                // Handle the error appropriately.
            case .badUsernameOrPassword:
                print("Connection refused: Bad username or password")
                // Handle the error appropriately.
            case .notAuthorized:
                print("Connection refused: Not authorized")
                // Handle the error appropriately.
            case .reserved: // unusure what this case means but it was missing
                print("Connection refused: Reserved")
            }
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        TRACE("new state: \(state)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        if let messageText = message.string {
            TRACE("message: \(message.string!.description), id: \(id)") // we can force it because the if statement safely checks for it
        } else {
            TRACE("empty message, id: \(id)")
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        TRACE("id: \(id)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("Recieved a Message")
        if let messageText = message.string {
            TRACE("message: \(message.string!.description), id: \(id)") // we can force it because the if statement safely checks for it
        } else {
            TRACE("Recieved a message with no text, id: \(id)")
        }
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.post(name: name, object: self, userInfo: ["message": message.string!, "topic": message.topic, "id": id])
        
        if let messageString = message.string {
            print("Message recieved in topic \(message.topic) with payload \(message.string!)")
            if (message.string == "lowerdeck") {
                print("Trying to go to lowerdeck")
                goToLowerDeck()
            } else if (message.string == "lowerdeck1") {
                print("Trying the pop up")
                var popUpWindow: PopUpWindow!
                popUpWindow = PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate.")
                popUpWindow.present(popUpWindow, animated: true, completion: nil)
            }
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        TRACE("subscribed: \(success), failed: \(failed)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        TRACE("topic: \(topics)")
    }

    func mqttDidPing(_ mqtt: CocoaMQTT) {
        TRACE()
    }

    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        TRACE()
    }

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        TRACE("\(String(describing: err))")
        let maxReconnectAttempts = 10
        var reconnectAttempts = 0
        if reconnectAttempts < maxReconnectAttempts {
            let backoffTime = pow(2.0, Double(reconnectAttempts)) * 5
            DispatchQueue.global().asyncAfter(deadline: .now() + backoffTime) {
                reconnectAttempts += 1
                mqtt.connect()
            }
        } else {
            print("Reached maximum reconnection attempts.")
        }
    }
}

extension MQTTManager {
    func TRACE(_ message: String = "", fun: String = #function) {
        let names = fun.components(separatedBy: ":")
        var prettyName: String
        if names.count == 2 {
            prettyName = names[0]
        } else {
            prettyName = names[1]
        }
        
        if fun == "mqttDidDisconnect(_:withError:)" {
            prettyName = "didDisconnect"
        }

        print("[TRACE] [\(prettyName)]: \(message)")
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) {
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            // Clean up tasks when it's done - but this would hopefully only happen if we call disconnect?
            // UIApplication.shared.endBackgroundTask(backgroundTask)
        }
    }
}
