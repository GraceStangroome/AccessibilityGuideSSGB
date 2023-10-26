//
//  ViewController.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 13/10/2023.
//  Contains all the go to functions and MQTT Controlling

import Foundation
import SwiftUI
import CocoaMQTT

class ViewController: UIViewController {
    
    let mqttClient = CocoaMQTT(clientID: "iPad", host: "raspberrypi.local", port: 1883)
    @State private var hasSetup = false
    @State private var onLowerFloor = false
    
    func setup() {
        mqttClient.logLevel = .debug
        mqttClient.username = "iPad1"
        mqttClient.password = "Apple"
        mqttClient.willMessage = CocoaMQTTMessage(topic: "/will", string: "dieout")
        mqttClient.keepAlive = 60
        mqttClient.delegate = self
        _ = mqttClient.connect()
        hasSetup = true
        print("finished setting up")
    }
    
    
    func notifyAreas(what: String) {
        NotificationCenter.default.post(name: Notification.Name(what), object: nil)
    }
    
    func publish(topic: String, content: String) {
        print("Publishing: \(content) to topic \(topic)")
        let array : [UInt8] = Array(content.utf8)
        let message = CocoaMQTTMessage(topic: topic, payload: array, qos: CocoaMQTTQoS.qos1, retained: true)
        mqttClient.publish(message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goToRoles() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: RoleView())
            window.makeKeyAndVisible()
        }
    }
    
    func goToInstructions() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView())
            window.makeKeyAndVisible()
        }
    }

    func goToLowerDeck() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: LowerDeckMapView())
            window.makeKeyAndVisible()
        }
        onLowerFloor = true
    }
    
    func goToMiddleDeck() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: MidDeckMapView())
            window.makeKeyAndVisible()
        }
    }
    
    func goToTopDeck() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: TopDeckMapView())
            window.makeKeyAndVisible()
        }
    }

    func makeAccessibilityReport() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: AccessibiltyReportUI())
            window.makeKeyAndVisible()
        }
    }

    func goToTelescope() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: TelescopeView())
            window.makeKeyAndVisible()
        }
    }

    func goToAccessibilityReport() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: HowToAccessibilityReportView())
            window.makeKeyAndVisible()
        }
    }
    
    func goToHowMapView() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: HowToMapView())
            window.makeKeyAndVisible()
        }
    }
    
    
    @IBAction func goToMap() {
        print("Got here")
        if hasSetup {
            _ = mqttClient.connect()
        } else {
            setup()
        }
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: mapView())
            window.makeKeyAndVisible()
        }
    }

}


extension ViewController: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("CONNECTION OCCURED")
        print(ack)
        switch ack {
        case .accept:
            print("Connection accepted. You are now connected to the broker.")
            mqtt.subscribe("messagesforiPad", qos: CocoaMQTTQoS.qos1)
            let message = CocoaMQTTMessage(topic: "MessagesFromiPad", string: "Connection successful", qos: CocoaMQTTQoS.qos1)
            mqtt.publish(message)
        case .unacceptableProtocolVersion:
            print("Connection refused: Unacceptable protocol version")
            notifyAreas(what: "unacceptableProtocolVersion")
        case .identifierRejected:
            print("Connection refused: Identifier rejected")
            notifyAreas(what: "identifierRejected")
        case .serverUnavailable:
            print("Connection refused: Server unavailable")
            notifyAreas(what: "serverUnavailable")
        case .badUsernameOrPassword:
            print("Connection refused: Bad username or password")
            notifyAreas(what: "badlogOn")
        case .notAuthorized:
            print("Connection refused: Not authorized")
            notifyAreas(what: "notAuthorized")
        case .reserved: // unusure what this case means but it was missing
            print("Connection refused: Reserved")
            notifyAreas(what: "reserved")
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Published: \(message)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("Did Publish: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("RECIEVED A MESSAGE")
        if let msgString = message.string {
            print("Message received in topic \(message.topic) with payload \(msgString)")
            if (msgString == "doPopUps") {
                notifyAreas(what: "doPopUps")
            }
            if (msgString == "0") {
                if !onLowerFloor {
                    goToLowerDeck()
                }
                notifyAreas(what: "onLowerDeck")
            } else if (msgString == "1") {
                notifyAreas(what: "onDiningSaloon")
            } else if (msgString == "2") {
                notifyAreas(what: "onEngineRoom")
            } else if (msgString == "3") {
                notifyAreas(what: "onHaywardSaloon")
            } else if (msgString == "4") {
                notifyAreas(what: "onHoldingBridge")
            } else if (msgString == "5") {
                notifyAreas(what: "onForwardHold")
            } else if (msgString == "6") {
                goToTopDeck()
                notifyAreas(what: "onTopDeck")
            } else if (msgString == "7") {
                notifyAreas(what: "onGoAloft")
            } else if (msgString == "8") {
                notifyAreas(what: "onForecastle")
            } else if (msgString == "9") {
                notifyAreas(what: "onAnimals")
            } else if (msgString == "10") {
                notifyAreas(what: "onSkylight")
            } else if (msgString == "11") {
                notifyAreas(what: "onWheel")
            } else if (msgString == "12") {
                goToMiddleDeck()
                notifyAreas(what: "onMidDeck")
            }
        } else {
            // it's a photo I think?
            print("Message was a photo")
            saveImgFromBytes(message.payload)
            // Then we tell the rest of the app that we created an image
            notifyAreas(what: "image")
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("\(success) \(failed)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("Unsubscribed from: \(topics)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("ping")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("pong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("error occured: \(String(describing: err))")
        notifyAreas(what: "errOccured")
    }
    
}

