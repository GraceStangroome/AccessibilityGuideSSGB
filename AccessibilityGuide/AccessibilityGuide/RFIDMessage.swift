//
//  RFIDMessage.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 21/09/2023.
//
//
//  Based upon ChatMessage.swift
//  In the CocoaMQTT Example
//
//  Created by CrazyWisdom on 16/1/1.
//  Copyright © 2016年 emqtt.io. All rights reserved.
//

import Foundation

class RFIDMessage {
    let id: UInt16 // each message that comes in will have a unique ID
    let sender: String // It will always come from the same sender I suppose but seems relevant to add just in case
    let tag: String // This contains the actual RFID Tag
    
    init(sender: String, tag: String, id: UInt16) {
        self.sender = sender
        self.tag = tag
        self.id = id
    }
}
