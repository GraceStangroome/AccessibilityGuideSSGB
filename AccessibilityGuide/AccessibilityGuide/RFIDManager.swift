//
//  RFIDManager.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 21/09/2023.
//
//  Based upon ChatViewController.swift
//  in the CocoaMQTT Example
//
//  Created by CrazyWisdom on 15/12/24.
//  Copyright © 2015年 emqtt.io. All rights reserved.
//


import Foundation
import CocoaMQTT

// This function listens to the RFID reader constantly, and if it gets a message, dispays a pop up window, or switches the map view(?)
class RFIDManager: UIViewController {
    
    var mqtt5: CocoaMQTT5?
    var mqtt: CocoaMQTT?
    var client: String?
    var mqttVersion: String? = "5.0"

    var messages: [RFIDMessage] = [] {
        didSet {
            scrollToBottom()
        }
    }
    
    func doThings() -> String {
        let viewController = ViewController()
        print("Started doing things")
        if messages.count > 0 {
            let message = messages[messages.count]
            if (message.tag == "lowerdeck") {
                print("Trying to go to lowerdeck")
                viewController.goToLowerDeck()
            }
            
            else if (message.tag == "lowerdeck1") {
                print("Trying the pop up")
                var popUpWindow: PopUpWindow!
                popUpWindow = PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate.")
                self.present(popUpWindow, animated: true, completion: nil)
            }
        }
        return "Done"
    }
    
    @IBAction func sendMessage(message: String) {

        let publishProperties = MqttPublishProperties()
        publishProperties.contentType = "JSON"

        if mqttVersion == "3.1.1" {
            mqtt!.publish("iPad/", withString: message, qos: .qos1)
        }
        else if mqttVersion == "5.0" {
            mqtt5!.publish("iPad/", withString: message, qos: .qos1, DUP: true, retained: false, properties: publishProperties)
        }
    }

    @IBAction func disconnect() {
        mqtt!.disconnect()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func disconnectMessage(notification: NSNotification) {
        disconnect()
    }


    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let content = userInfo["tag"] as! String
        let topic = userInfo["topic"] as! String
        let id = UInt16(userInfo["id"] as! UInt16)
        let sender = topic.replacingOccurrences(of: "iPad", with: "")
        let rfidmessage = RFIDMessage(sender: sender, tag: content, id: id)
        messages.append(rfidmessage)
    }

    
    func scrollToBottom() {
        let count = messages.count
        if count > 3 {
            let indexPath = IndexPath(row: count - 1, section: 0)
        }
    }


}
