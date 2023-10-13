//
//  ViewController.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 13/10/2023.
//  Contains all the go to functions and some

import Foundation
import SwiftUI
import CocoaMQTT

class ViewController: UIViewController {
    let mqttClient = CocoaMQTT(clientID: "iPad", host: "raspberrypi.local", port: 1883)
    
    func setup() {
        mqttClient.logLevel = .debug
        mqttClient.username = "iPad"
        mqttClient.password = "Apple!"
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
        setup()
        _ = mqttClient.connect()
        // mqttClient.subscribe("MessagesforiPad")
        mqttClient.publish("MessagesforiPad", withString: "connection successful")
        
        /// _ mqtt5: CocoaMQTT5, didReceiveAuthReasonCode reasonCode: CocoaMQTTAUTHReasonCode
        
    //    if let window = UIApplication.shared.windows.first {
    //        window.rootViewController = UIHostingController(rootView: mapView())
    //        window.makeKeyAndVisible()
     //   }
    }
}
