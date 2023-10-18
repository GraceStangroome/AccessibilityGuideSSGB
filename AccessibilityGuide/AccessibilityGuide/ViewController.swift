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
    
    func setup() {
        mqttClient.logLevel = .debug
        mqttClient.username = "iPad"
        mqttClient.password = "Apple!"
        mqttClient.willMessage = CocoaMQTTMessage(topic: "/will", string: "dieout")
        mqttClient.keepAlive = 60
        mqttClient.delegate = self
        _ = mqttClient.connect()
        hasSetup = true
        print("finished setting up")
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
    
    // this next bit handles the automatic popping up when mqtt stuff occurs
    struct popUpViewController: View {
        var body: some View {
            NavigationView {
                if PopUpStates.showLowerDeckPop {
                    PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate."))
                }
                if PopUpStates.showDiningSaloonPop {
                    PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "First Class Dining Saloon", text: "There were four mealtimes for the first-class passengers: breakfast at 9am; lunch at 12pm; supper at 4pm; and dinner at 7:30pm. Would you like to join Annie Henning and Isambard Kingdom Brunel for a meal?"))
                }
            }
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
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Published: \(message)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("Did Publish: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("RECIEVED A MESSAGE")
        if let msgString = message.string {
            print("Message recieved in topic \(message.topic) with payload \(msgString)")
            if (msgString == "lowerdeck") {
                print("Trying to go to lowerdeck")
                PopUpStates.showLowerDeckPop = true
                print (PopUpStates.showLowerDeckPop)
                goToLowerDeck()
            } else if (msgString == "lowerdeck1") {
                print("Trying the pop up")
                PopUpStates.showDiningSaloonPop = true
                print (PopUpStates.showDiningSaloonPop)
            }
        }
        popUpViewController
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
    }
    
}

