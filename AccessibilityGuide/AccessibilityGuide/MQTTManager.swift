//
//  MQTTSubscriber.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 14/09/2023.
//  Responsible for subscribing and publishing to the MQTT broker
//  Using CocoaMQTT

import CocoaMQTT

class MQTTManager {
    
    let mqtt = CocoaMQTT(clientID: "iPad", host: "192.169.0.12", port: 1883)
    
    init() {
        configureMQTT()
    }
    
    func configureMQTT() {
        // Configure connection and message handlers here
        mqtt.logLevel = .debug
        mqtt.username = "iPad"
        mqtt.password = "Apple!"
        mqtt.keepAlive = 60
        mqtt.autoReconnect = true
        mqtt.autoReconnectTimeInterval = 5
        
    }
    
    // successful connection
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("Connected to \(host) on port \(port)")
    }
    
    // unsuccessful connection
    func mqtt(_ mqtt: CocoaMQTT, withError err: Error?) {
        if let error = err {
            print("Disconnected with error: \(error.localizedDescription)")
        } else {
            print("Disconnected")
        }
        connect()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didRecieveMessage message: CocoaMQTTMessage, id: UInt16) {
        if let messageString = message.string {
            print("Message recieved in topic \(message.topic) with payload \(message.string!)")
            if (message.string == "lowerdeck") {
                print("Trying to go to lowerdeck")
                goToLowerDeck()
            }
            
            else if (message.string == "lowerdeck1") {
                print("Trying the pop up")
                var popUpWindow: PopUpWindow!
                popUpWindow = PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate.")
                popUpWindow.present(popUpWindow, animated: true, completion: nil)
            }
        }
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
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
    
    func connect() {
        let result = mqtt.connect()
        print("Connection was successful? \(result)")
    }
    
    func subscribe(toTopic topic: String) {
        mqtt.subscribe(topic)
    }
    
    func publish(topic: String, content: String) {
        let array : [UInt8] = Array(content.utf8)
        let message = CocoaMQTTMessage(topic: topic, payload: array, qos: CocoaMQTTQoS.qos2, retained: true)
        mqtt.publish(message)
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
