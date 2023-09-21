//
//  ssgbMap.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 02/08/2023.
//

import SwiftUI

struct mapView: View {
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack{
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 50))
                        .bold()
                        .padding([.leading, .top], 25)
                    Text("Instructions for Getting Started")
                        .font(.system(size: 40))
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 680, height: 10, alignment: .leading)
                Spacer()
                Button(action: goToInstructions){
                    Text("Instruction Page")
                        .font(.system(size: 40))
                        .multilineTextAlignment(.trailing)
                        .padding([.leading, . bottom], 40)
                        .padding([.leading], 20)
                    Image(systemName: "questionmark")
                        .font(.system(size: 45))
                        .multilineTextAlignment(.trailing)
                        .padding([.bottom], 40)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(40)
            .padding([.bottom], 25)
            .foregroundColor(Color.white)
            .background(Color.red)
            VStack {
                HStack{
                    Text("Currently Viewing:" ).padding([.leading], -190)
                        .font(.system(size: 35))
                    VStack{
                        Text("Choose a location or").bold().padding([.leading], -220)
                            .font(.system(size: 25))
                        Text("the Telescope will change the map for you").bold().padding([.leading], 20)
                            .font(.system(size: 25))
                    }
                    Spacer()
                    Menu("Touch here to see the \nlocation list"){
                        Button(action: goToMap){Text("The Ship: Dry Dock")}
                        Button(action: goToMap){Text("The Ship: Top Deck")}
                        Button(action: goToLowerDeck){Text("The Ship: Lower Deck")}
                        Button(action: goToMap){Text("The Ship: Middle Deck")}
                        Button(action: goToMap){Text("Being Brunel: Ground")}
                        Button(action: goToMap){Text("Being Brunel: First")}
                    }
                    .font(.system(size: 30))
                    .foregroundColor(Color.black)
                   .frame(width: 350, height: 75)
                   .multilineTextAlignment(.leading)
                }
                .padding([.leading], 200)
                .frame(minWidth: 0, maxWidth: .infinity)
                Image(systemName: "rectangle")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    .frame(width: 1250, height: 550)
                HStack {
                    Text("Accessibility needs are different for everyone\nclick HERE to make an accessibility report without a photo")
                        .font(.system(size: 40)).bold()
                        .frame( height: 150)
                        .padding([.bottom], 30)
                } // CLosing the Roles button
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color.red)
            } // Closing the main body
        } // Closing the entire screen
    } // CLosing the body
} // Closing the View


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


// need something here about listening for theb messages from the telescope?
// if it gets one
// find which one it is and pull the appropriate message from somewhere?


struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
