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
    var mqttVersion: String?

    var messages: [RFIDMessage] = [] {
        didSet {
            scrollToBottom()
        }
    }
    
    func doThings() -> String {
        let message = messages[messages.count - 1]
        if (message.tag == "lowerdeck") {
            goToLowerDeck()
        }
        
        else if (message.tag == "lowerdeck1") {
            var popUpWindow: PopUpWindow!
            popUpWindow = PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate.")
            self.present(popUpWindow, animated: true, completion: nil)
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
        
        if mqttVersion == "3.1.1" {
            mqtt!.disconnect()
        }else if mqttVersion == "5.0" {
            mqtt5!.disconnect()
            //or
            //mqtt5!.disconnect(reasonCode: CocoaMQTTDISCONNECTReasonCode.disconnectWithWillMessage, userProperties: ["userone":"hi"])
        }
        
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

    @objc func receivedMqtt5Message(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let message = userInfo["message"] as! String
        let topic = userInfo["topic"] as! String
        let id = UInt16(userInfo["id"] as! UInt16)
        //let sender = userInfo["animal"] as! String
        let sender = topic.replacingOccurrences(of: "messages", with: "")
        let content = String(message.filter { !"\0".contains($0) })
        let chatMessage = RFIDMessage(sender: sender, tag: content, id: id)
        print("sendersendersender =  \(sender)")
        messages.append(chatMessage)
    }
    
    func scrollToBottom() {
        let count = messages.count
        if count > 3 {
            let indexPath = IndexPath(row: count - 1, section: 0)
        }
    }


}
