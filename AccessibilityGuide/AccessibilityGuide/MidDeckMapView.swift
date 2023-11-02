//
//  MidDeckMapView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 25/10/2023.
//

import SwiftUI

import UIKit


struct MidDeckMapView: View {
    @State var viewController = ViewController()
    @State private var showMidDeckPop = false
    @State private var onMidDeck = true // this means that this displays automatically when the page loads
    // The following needs refactoring for this floors pop ups but you can keep most of the code
    // You may need to add more
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
    // Keep these as is
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
                        Text("The Ship: Middle Deck").bold()
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
                    Image("middleDeck")
                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .frame(width: 1050, height: 400)
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
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onWheel"))) { _ in
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
                        .sheet(isPresented: $showMidDeckPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "You are now on the Middle Deck", text: "The Middle Deck has many narrow passageways, low ceilings, and unique floors. Please take extra care getting around!"))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onMidDeck {
                                showMidDeckPop = true
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
                    // The rest of the pop ups need to be refactored to contain the correct fun facts for this floor
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
                    // Overlaying buttons
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false).position(x: 380, y: 150)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)
                        .position(x: 635, y: 150)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: true, isStairs: true)
                        .position(x: 400, y: 200)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: true, isStairs: true).position(x: 655, y: 200)
                    overlayingButton(imageName: "narrowPass", buttonText: "Narrow Pass", isSystem: false, isStairs: false)
                        .position(x: 811, y: 200)
                    overlayingButton(imageName: "chair.lounge.fill", buttonText: "Seating", isSystem: true, isStairs: false)
                        .position(x: 875, y: 200)
                    overlayingButton(imageName: "chair.lounge.fill", buttonText: "Seating", isSystem: true, isStairs: false)
                        .position(x: 939, y: 200)
                    overlayingButton(imageName: "grilledFlooring", buttonText: "Grilled Flooring", isSystem: false, isStairs: false).position(x:580, y: 245)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: true, isStairs: true).position(x: 655, y: 290)
                    overlayingButton(imageName: "narrowPass", buttonText: "Narrow Pass", isSystem: false, isStairs: false)
                        .position(x: 811, y: 290)
                    overlayingButton(imageName: "narrowPass", buttonText: "Narrow Pass", isSystem: false, isStairs: false)
                        .position(x: 875, y: 290)
                    overlayingButton(imageName: "narrowPass", buttonText: "Narrow Pass", isSystem: false, isStairs: false)
                        .position(x: 1015, y: 320)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)   .position(x: 375, y: 350)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)   .position(x: 475, y: 350)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)   .position(x: 590, y: 350)
                    overlayingButton(imageName: "narrowPass", buttonText: "Narrow Pass", isSystem: false, isStairs: false)
                        .position(x: 690, y: 340)
                    // Then we have the sensory information overlaying buttons that occur only as you move around
                    if onDiningSaloon || showAllPoints {
                        
                    }
                    if onEngineRoom || showAllPoints {
                        
                    }
                    if onHaywardSaloon || showAllPoints {
                        
                    }
                    if onHoldingBridge || showAllPoints {
                        
                    }
                    if onForwardHold || showAllPoints {
                        
                    }
                
                } // end of ZStack
                HStack{
                    Text("Accessibility needs are different for everyone. Click")
                    Button(action: viewController.makeAccessibilityReport) {
                        Text("HERE  ")
                            .font(.system(size: 25)).bold().foregroundColor(Color.red).background(Color.white)
                    } // CLosing the Accessibility report button
                    .mask {
                                RoundedRectangle(cornerRadius: 5)
                    }
                    Text("to make an accessibility report")
                }
                .font(.system(size: 25)).bold()
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 90)
                .foregroundColor(Color.white)
                .background(Color.red)
            } // Closing the main body
        } // Closing the entire screen
    } // CLosing the body
} // Closing the View

#Preview {
    MidDeckMapView()
}
