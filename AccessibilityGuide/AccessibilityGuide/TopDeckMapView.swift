//
//  TopDeckMapView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 26/10/2023.
//

import SwiftUI

struct TopDeckMapView: View {
    @State var viewController = ViewController()
    @State private var showTopDeckPop = false
    @State private var onTopDeck = true // this means that this displays automatically when the page loads
    @State private var showGoAloftPop = false
    @State private var onGoAloft = false
    @State private var showForecastlePop = false
    @State private var onForecastle = false
    @State private var showAnimalsPop = false
    @State private var onAnimals = false
    @State private var showSkylightPop = false
    @State private var onSkylight = false
    @State private var showWheelPop = false
    @State private var onWheel = false
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
                        Text("The Ship: Top Deck").bold()
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
                    Image("Top Deck")
                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .frame(width: 1050, height: 400)
                        .padding()
                    
                    // Listening for instructions
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            print("Will do PopUps now")
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onGoAloft"))) { _ in
                            onGoAloft = true
                            onForecastle = false
                            onWheel = false
                            onAnimals = false
                            onSkylight = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onForecastle"))) { _ in
                            onGoAloft = false
                            onForecastle = true
                            onWheel = false
                            onAnimals = false
                            onSkylight = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onSkylight"))) { _ in
                            onGoAloft = false
                            onForecastle = false
                            onWheel = true
                            onAnimals = false
                            onSkylight = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onAnimals"))) { _ in
                            onGoAloft = false
                            onForecastle = false
                            onWheel = false
                            onAnimals = true
                            onSkylight = false
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("onWheel"))) { _ in
                            onGoAloft = false
                            onForecastle = false
                            onWheel = false
                            onAnimals = false
                            onSkylight = true
                        }
                    // Pop Up Code
                        .sheet(isPresented: $showTopDeckPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Welcome aboard the SS Great Britain!", text: "Built in the Great Western Dockyard in Bristol, The SS Great Britain was launched on 19 July 1843."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onTopDeck {
                                showTopDeckPop = true
                            }
                        }
                        .sheet(isPresented: $showGoAloftPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Try being a crew member at Go Aloft!", text: "Some passengers would get so bored, they would end up working alongside the crew! This was great for the captain as whenever the ship would get stuck in a storm, he would need every able body on deck."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onGoAloft {
                                showGoAloftPop = true
                            }
                        }
                        .sheet(isPresented: $showForecastlePop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Do not distrub!", text: "The forecastle, or fo’c’sle, is the forward part of the ship with the crew’s living quarters. This means crew only in this area!"))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onForecastle {
                                showForecastlePop = true
                            }
                        }
                        .sheet(isPresented: $showAnimalsPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Don't mind the animals...", text: "Animals, including pigs, sheep, cows, and poultry, were kept on the top deck in pens and crates. The animals would be killed throughout the voyage to provide the passengers with fresh meat."))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onAnimals {
                                showAnimalsPop = true
                            }
                        }
                        .sheet(isPresented: $showSkylightPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "What's down below?", text: "Peer through the glazed skylight and you should be able to see the great engine wheel turning!"))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onSkylight {
                                showSkylightPop = true
                            }
                        }
                        .sheet(isPresented: $showWheelPop) {
                            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Off to New York", text: "The upper deck looks today much as it did in 1845, when the first passengers went aboard at the start of their voyage to New York. Do you know which way to turn the wheel to get us to New York?"))
                        }
                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("doPopUps"))) { _ in
                            doPopUps = true
                            if doPopUps && onWheel {
                                showWheelPop = true
                            }
                        }
                    // end of pop up code
                    // Overlaying buttons
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: false, isStairs: true)
                        .position(x: 480, y: 165)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: false, isStairs: true)
                        .position(x: 740, y: 170)
                    overlayingButton(imageName: "ramp", buttonText: "Ramp", isSystem: false, isStairs: false)
                        .position(x: 300, y: 300)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: true, isStairs: true)
                        .position(x: 390, y: 300)
                    overlayingButton(imageName: "information", buttonText: "Information", isSystem: false, isStairs: false)
                        .position(x: 450, y: 300)
                    overlayingButton(imageName: "elevator", buttonText: "Elevator", isSystem: false, isStairs: false)
                        .position(x: 578, y: 225)
                    overlayingButton(imageName: "stairs", buttonText: "Stairs to other decks", isSystem: false, isStairs: true)
                        .position(x: 740, y: 300)
                    // Then we have the conditional overlaying buttons
                    if onGoAloft || showAllPoints {
                        Text("Go Aloft! \nTickets").bold()
                            .foregroundStyle(Color.red).position(x: 375, y: 230)
                        sensoryOverlayingButton(imageName: "hand.point.up.left", buttonText: "Climb the mast", colour: 0).position(x: 435, y: 230)
                        sensoryOverlayingButton(imageName: "eye", buttonText: "Floor Slippery \nWhen Wet", colour: UInt32("C3A86B", radix: 16) ?? 0).position(x: 435, y: 265)
                    }
                    if onForecastle || showAllPoints {
                        Text("Fo'c'lse").bold()
                            .foregroundStyle(Color.red).position(x: 190, y: 230)
                    }
                    if onAnimals || showAllPoints {
                        sensoryOverlayingButton(imageName: "ear", buttonText: "Recorded Sounds: \nChains Rattling \nCow and Pig", colour: 0)
                            .position(x: 500, y:230)
                    }
                    if onSkylight || showAllPoints {
                        sensoryOverlayingButton(imageName: "eye", buttonText: "Look through \nthe skylight", colour: 0).position(x: 665, y:230)
                    }
                    if onWheel || showAllPoints {
                        Text("Ship's \nWheel").bold()
                            .foregroundStyle(Color.red).position(x: 880, y: 235)
                        sensoryOverlayingButton(imageName: "hand.point.up.left", buttonText: "Turn the ship's wheel", colour: 0).position(x: 930, y: 235)
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

#Preview {
    TopDeckMapView()
}
