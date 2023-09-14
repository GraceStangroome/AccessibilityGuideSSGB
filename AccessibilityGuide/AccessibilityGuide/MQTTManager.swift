//
//  MQTTSubscriber.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 14/09/2023.
//  Responsible for subscribing and publishing to the MQTT broker
// code from https://appcodelabs.com/introduction-to-iot-how-to-send-mqtt-messages-from-ios-using-swift
//

import Foundation
import MQTTClient

class ClientMQTTManager: UIViewController {
    let MQTT_HOST = "" // host name or IP address
    let MQTT_PORT: UInt32 = 1883
    
    private var transport = MQTTCFSocketTransport()
    fileprivate var session = MQTTSession()
    fileprivate var completion: (()->())?
    
    let mqttClient = CocoaMQTT(clientID: "swift", host: "mqtt.eclipse.org", port: 1883)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.session?.delegate = self
        self.transport.host = MQTT_HOST
        self.transport.port = MQTT_PORT
        session?.transport = transport
        
        self.setUIStatus(for: self.session?.status ?? .created)
        session?.connect() { error in
            print("connection completed with status \(String(describing: error))")
            if error != nil {
                self.setUIStatus(for: self.session?.status ?? .created)
            } else {
                self.setUIStatus(for: self.session?.status ?? .error)
            }
        }
    }
    private func updateUser(for clientStatus: MQTTSessionStatus) {
            DispatchQueue.main.async {
                switch clientStatus {
                    case .connected:
                        print("Connected")
                    case .connecting,
                         .created:
                        print("Trying to connect...")
                    default:
                        print("Connection Failed")
                }
            }
        }
    private func publishMessage(_ message: String, onTopic: String) {
            session?.publishData(message.data(using: .utf8, allowLossyConversion: false), onTopic: "test/message", retain: false, qos: .exactlyOnce)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        guard session?.status == .connected else {
            self.updateUI(for: self.session?.status ?? .error)
            return
        }
        let state = !sender.isSelected
        sender.isEnabled = false
        completion = {
            sender.isSelected = state
            sender.isEnabled = true
        }
        print("setting state to \(state)")
        publishMessage(state ? "on" : "off", onTopic: "test/message")
    }
}
