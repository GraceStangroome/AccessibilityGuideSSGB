//
//  ssgbMap.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 06/09/2023.
//

import SwiftUI

import UIKit


struct LowerDeckMapView: View {
    @State var viewController = ViewController()
    @State private var showLowerDeckPop = false
    @State private var onLowerDeck = true // this means that this displays automatically when the page loads
    @State private var showDiningSaloonPop = false
    @State private var onDiningSaloon = false
    @State private var showEngineRoomPop = false
    @State private var onEngineRoom = false
    @State private var showHaywardSaloonPop = false
    @State private var onHaywardSaloon = false
    @State private var showHoldingBridgePop = false
    @State private var onHoldingBridge = false
    @State private var showForwardHoldPop = false
    @State private var onForwardHold = false
    @State private var doPopUps = false
    @State private var showAllPoints = false
    @State private var showAllPointsPop = false
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .leading)
                VStack(alignment: .leading){
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 40))
                        .bold()
                        .padding([.bottom, .top], 10)
                        .padding([.top], 20)
                    VStack(alignment: .leading){
                        Text("If the telescope buzzes, the map will tell you what you are near.")
                        .font(.system(size: 20))
                        Text("You can then expand the telescope to get more information.")
                            .font(.system(size: 20))
                    }
                    .padding([.bottom], 30)
                }
                .frame(width: 600, height: 100)
                Spacer()
                VStack{
                    HStack{
                        Button(action: viewController.goToInstructions){  Text("Instruction Page")
                                .multilineTextAlignment(.trailing)
                                .padding([ .bottom], 30)
                                .font(.system(size: 21))
                            Image(systemName: "questionmark")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.trailing)
                                .padding([.bottom], 40)
                        }
                    }
                    Button(action: {
                        showAllPoints.toggle()
                        if showAllPoints == true {
                            showAllPointsPop = true
                        }
                    }) {
                        Text("Press \(Text("here").bold()) to show all\ninformation points")
                            .font(.system(size: 18))
                    }.sheet(isPresented: $showAllPointsPop) {
                        PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Showing All Information Points", text: "This will temporarily ovveride the telescope, however, once triggered, all information points display unless you press this again"))
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(Color.white)
            .background(Color.red)
            VStack {
                HStack{
                    Text("Currently Viewing:" ).padding([.leading], -140)
                        .font(.system(size: 21))
                        Text("The Ship: Lower Deck").bold()
                        .font(.system(size: 29))
                    Spacer()
                    Menu("Touch \(Text("here").bold()) to see the \nlocation list"){
                        Button(action: viewController.goToTopDeck){Text("The Ship: Top Deck")}
                        Button(action: viewController.goToMiddleDeck){Text("The Ship: Middle Deck")}
                        Button(action: viewController.goToLowerDeck){Text("The Ship: Lower Deck")}
                    }
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                   .frame(width: 350, height: 75)
                   .multilineTextAlignment(.leading)

                }
                .padding([.leading], 200)
                .frame(minWidth: 0, maxWidth: .infinity)
                ZStack {
                    Image("lowerdeck")
                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .frame(width: 1000, height: 400)
                        .padding()
                    
                    // Listening for instructions
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            print("Will do PopUps now")
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onDiningSaloon"))) { _ in
                            onDiningSaloon = true
                            onEngineRoom = false
                            onForwardHold = false
                            onHaywardSaloon = false
                            onHoldingBridge = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onEngineRoom"))) { _ in
                            onDiningSaloon = false
                            onEngineRoom = true
                            onForwardHold = false
                            onHaywardSaloon = false
                            onHoldingBridge = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onForwardHold"))) { _ in
                            onDiningSaloon = false
                            onEngineRoom = false
                            onForwardHold = true
                            onHaywardSaloon = false
                            onHoldingBridge = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onHaywardSaloon"))) { _ in
                            onDiningSaloon = false
                            onEngineRoom = false
                            onForwardHold = false
                            onHaywardSaloon = true
                            onHoldingBridge = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onHoldingBridge"))) { _ in
                            onDiningSaloon = false
                            onEngineRoom = false
                            onForwardHold = false
                            onHaywardSaloon = false
                            onHoldingBridge = true
                        }
                    // Pop Up Code
                        .sheet(isPresented: $showLowerDeckPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onLowerDeck {
                                showLowerDeckPop = true
                            }
                        }
                        .sheet(isPresented: $showDiningSaloonPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "First Class Dining Saloon", text: "There were four mealtimes for the first-class passengers: breakfast at 9am; lunch at 12pm; supper at 4pm; and dinner at 7:30pm. Would you like to join Annie Henning and Isambard Kingdom Brunel for a meal?"))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onDiningSaloon {
                                showDiningSaloonPop = true
                            }
                        }
                        .sheet(isPresented: $showEngineRoomPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Engine Room", text: "There were lots of different jobs on the SS Great Britain, including roles linked to keeping the ship moving such as seamen, sailmakers and coal trimmers. "))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onEngineRoom {
                                showEngineRoomPop = true
                            }
                        }
                        .sheet(isPresented: $showHaywardSaloonPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Hayward Saloon", text: "Named after Jack Hayward, the English philanthropist who gave £150,000 to fund the rescue of the SS Great Britain and help bring her back to Bristol."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onHaywardSaloon {
                                showHaywardSaloonPop = true
                            }
                        }
                        .sheet(isPresented: $showHoldingBridgePop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Holding Bridge and Cargo Deck", text: "Passengers on the SS Great Britain could only access their trunks in the hold after one month at sea, and therefore had to rely on their ‘hand luggage’ for spare clothes."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onHoldingBridge {
                                showHoldingBridgePop = true
                            }
                        }
                        .sheet(isPresented: $showForwardHoldPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Forward Hold", text: "During the Crimean War the ship transported soldiers and their horses to Malta to ready themselves for battle. Conditions on the ship were hot and cramped and the horses brought many pests with them."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onForwardHold {
                                showForwardHoldPop = true
                            }
                        }
                    // end of pop up code
                    // map labels
                    VStack {
                        Text("Stepped Exit")
                        Image(systemName: "arrow.up")
                            .bold()
                            .font(.system(size:32))
                    }
                    .position(x: 370, y: 120)
                    
                    VStack {
                        Image(systemName: "arrow.down")
                            .bold()
                            .font(.system(size:32))
                        Text("Accessible Exit")
                    }
                    .position(x: 370, y: 340)
                    
                    // Overlaying buttons
                    overlayingButton(imageName: "grilledFlooring", buttonText: "Grilled Flooring", isSystem: false, isStairs: false)
                        .position(x: 250, y: 190)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: true, isStairs: true)
                        .position(x: 450, y: 160)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to \n other decks", isSystem: true, isStairs: true)
                        .position(x: 660, y: 200)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to \n other decks", isSystem: true, isStairs: true)
                        .position(x: 660, y: 270)
                    overlayingButton(imageName: "chair.lounge.fill", buttonText: "Seating", isSystem: true, isStairs: false)
                        .position(x: 730, y: 260)
                    overlayingButton(imageName: "chair.lounge.fill", buttonText: "Seating", isSystem: true, isStairs: false)
                        .position(x: 805, y: 260)
                    overlayingButton(imageName: "chair.lounge.fill", buttonText: "Seating", isSystem: true, isStairs: false)
                        .position(x: 730, y: 205)
                    overlayingButton(imageName: "chair.lounge.fill", buttonText: "Seating", isSystem: true, isStairs: false)
                        .position(x: 805, y: 205)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)
                        .position(x: 435, y: 320)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)
                        .position(x: 530, y: 320)
                    overlayingButton(imageName: "toilet", buttonText: "Bathroom", isSystem: false, isStairs: false)
                        .position(x: 577, y: 320)
                    overlayingButton(imageName: "disabledToilet", buttonText: "Accessible Bathroom", isSystem: false, isStairs: false)
                        .position(x: 612, y: 320)
                    // Then we have the conditional overlaying buttons
                    if onDiningSaloon || showAllPoints {
                        sensoryOverlayingButton(imageName: "ear", buttonText: "Recorded Sounds: The sea, \n the ship’s engine propeller, and bell. \n People moving and talking, \n seasick passengers, chinking of tableware, \n musicians warming up", colour: 0)
                            .position(x: 695, y: 210)
                        sensoryOverlayingButton(imageName: "nose", buttonText: "Artifical Smell: Dark chocolate orange", colour: 0)
                            .position(x: 695, y: 260)
                        sensoryOverlayingButton(imageName: "person", buttonText: "Mannequin", colour: 0)
                            .position(x: 770, y: 260)
                        Text("First Class Dining Saloon").bold()
                            .foregroundStyle(Color.red)
                            .position(x: 790, y: 236)
                    }
                    if onEngineRoom || showAllPoints {
                        sensoryOverlayingButton(imageName: "person", buttonText: "Mannequin", colour: 0)
                            .position(x: 560, y: 255)
                    }
                    if onHaywardSaloon || showAllPoints {
                        Text("Hayward \nSaloon")
                            .bold()
                            .foregroundStyle(Color.red)
                            .position(x: 470, y: 270)
                    }
                    if onHoldingBridge || showAllPoints {
                        sensoryOverlayingButton(imageName: "ear", buttonText: "Recorded Sounds: Horses \n Sounds from the Steerage \n Low hum from the dehumidifier", colour: 0)
                            .position(x: 345, y: 195)
                        sensoryOverlayingButton(imageName: "nose", buttonText: "Artifical Smell: Horse manure", colour: 0)
                            .position(x: 345, y: 250)
                    }
                    if onForwardHold || showAllPoints {
                        sensoryOverlayingButton(imageName: "ear", buttonText: "Recorded Sounds: Horses \n Sounds from the Steerage \n Low hum from the dehumidifier", colour: 0)
                            .position(x: 345, y: 195)
                        sensoryOverlayingButton(imageName: "nose", buttonText: "Artifical Smell: Horse manure", colour: 0)
                            .position(x: 345, y: 250)
                        sensoryOverlayingButton(imageName: "person", buttonText: "Mannequin", colour: 0)
                            .position(x: 288, y: 230)
                        Text("Forward \nHold") .bold()
                            .foregroundStyle(Color.red)
                            .position(x: 230, y: 255)
                    }
                
                } // end of ZStack
                Button(action: viewController.makeAccessibilityReport) {
                    Text("Accessibility needs are different for everyone\nclick \(Text("HERE").bold()) to make an accessibility report without a photo")
                        .font(.system(size: 25)).bold()
                        .padding([.bottom], 30)
                } // Closing the Accessibility report button
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 90)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
            } // Closing the main body
        } // Closing the entire screen
    } // CLosing the body
} // Closing the View

struct LowerDeckMapView_Previews: PreviewProvider {
    static var previews: some View {
        LowerDeckMapView()
    }
}
