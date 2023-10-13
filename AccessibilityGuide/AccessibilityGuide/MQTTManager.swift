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
    var setupOccured = Bool(false)
    
    init() {
        mqttSettingList()
    }
    
    func mqttSettingList() {
        print("Configuring")
        configureMQTT()
        setupOccured = true
    }
    
    
    func configureMQTT() {
        print("Setting up MQTT")
        // Configure connection and message handlers here
        let mqtt = CocoaMQTT(clientID: "iPad", host: "raspberrypi.local", port: 1883)
        mqtt.logLevel = .debug
        mqtt.username = "iPad"
        mqtt.password = "Apple!"
        let message = "will dieout"
        let payload: [UInt8] = Array(message.utf8)
        mqtt.willMessage = CocoaMQTTMessage(topic: "messagesFromiPad", payload: payload)
        mqtt.keepAlive = 60
        mqtt.autoReconnect = true
        mqtt.autoReconnectTimeInterval = 5
        mqtt.enableSSL = false
        mqtt.allowUntrustCACertificate = true
        let delegator = MQTTManagerDelegate()
        mqtt.delegate = delegator
    }

    
    func connect() {
        print("connecting...")
        if !setupOccured {
            mqttSettingList()
        }
        _ = mqtt.connect()
    }
    
    func subscribe(toTopic topic: String) {
        mqtt.subscribe(topic)
        print("Subscribed to topic: \(topic)")
    }
    
    func publish(topic: String, content: String) {
        print("Publishing: \(content) to topic \(topic)")
        let array : [UInt8] = Array(content.utf8)
        let message = CocoaMQTTMessage(topic: topic, payload: array, qos: CocoaMQTTQoS.qos1, retained: true)
        mqtt.publish(message)
    }
    
    func disconnect() {
        print("DISCONNECT OCCURED")
        mqtt.disconnect()
    }
}
    
class MQTTManagerDelegate: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("CONNECTION OCCURED")
        print(ack)
        TRACE("ack: \(ack)")
        switch ack {
        case .accept:
            print("Connection accepted. You are now connected to the broker.")
            mqtt.subscribe("messagesforiPad", qos: CocoaMQTTQoS.qos1)
            let message = CocoaMQTTMessage(topic: "MessagesFromiPad", string: "Connection successful", qos: CocoaMQTTQoS.qos1)
            mqtt.publish(message)
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

    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        print("NEW STATE")
        TRACE("new state: \(state)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("PUBLISHED")
        if message.string != nil {
            TRACE("message: \(message.string!.description), id: \(id)") // we can force it because the if statement safely checks for it
        } else {
            TRACE("empty message, id: \(id)")
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("PUBLISHING")
        TRACE("id: \(id)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        var viewController = ViewController()
        print("Recieved a Message")
        if message.string != nil {
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
                viewController.goToLowerDeck()
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
        if err != nil {
            TRACE("\(String(describing: err))")
            print("Disconnected with error \(String(describing: err))")
            let maxReconnectAttempts = 10
            var reconnectAttempts = 0
            while reconnectAttempts < maxReconnectAttempts {
                let backoffTime = pow(2.0, Double(reconnectAttempts)) * 5
                DispatchQueue.global().asyncAfter(deadline: .now() + backoffTime) {
                    reconnectAttempts += 1
                    _ = mqtt.connect()
                    print("attempted recconection")
                }
            }
            print("Reached maximum reconnection attempts.")
        } else {
            print("MQTT Disconnected")
            _ = mqtt.connect()
        }
    }
    
}

extension MQTTManagerDelegate {
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

extension Optional {
    var description: String {
        if let self = self {
            return "\(self)"
        }
        return ""
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
