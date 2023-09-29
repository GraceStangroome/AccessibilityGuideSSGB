//
//  ssgbMap.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 06/09/2023.
//

import SwiftUI

import UIKit

// Custom button from https://stackoverflow.com/questions/29117759/how-to-create-radio-buttons-and-checkbox-in-swift-ios


struct LowerDeckMapView: View {
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .leading)
                VStack{
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 40))
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding([.bottom, .top], 10)
                        .padding([.top], 20)
                    VStack{
                        Text("If the telescope buzzes, the map will tell you what you are near.")
                        .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)

                        Text("You can then expand the telescope to get more information.")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                       
                    }
                    .padding([.bottom], 30)
                }
                .frame(width: 600, height: 100)
                Spacer()
                VStack{
                    HStack{
                        Button(action: goToInstructions){  Text("Instruction Page")
                                .multilineTextAlignment(.trailing)
                                .padding([ .bottom], 30)
                                .font(.system(size: 21))
                            Image(systemName: "questionmark")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.trailing)
                                .padding([.bottom], 40)
                        }
                    }
                    HStack{
                        Text("Check to show all\ninformation points")
                            .font(.system(size: 18))
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
                    Menu("Touch here to see the \nlocation list"){
                        Button(action: goToMap){Text("The Ship: Dry Dock")}
                        Button(action: goToMap){Text("The Ship: Top Deck")}
                        Button(action: goToLowerDeck){Text("The Ship: Lower Deck")}
                        Button(action: goToMap){Text("The Ship: Middle Deck")}
                        Button(action: goToMap){Text("Being Brunel: Ground")}
                        Button(action: goToMap){Text("Being Brunel: First")}
                    }
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                   .frame(width: 350, height: 75)
                   .multilineTextAlignment(.leading)

                }
                .padding([.leading], 200)
                .frame(minWidth: 0, maxWidth: .infinity)
                Image("lower deck")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    .frame(width: 1000, height: 400)
                .padding()
                HStack {
                    Text("Accessibility needs are different for everyone\nclick HERE to make an accessibility report without a photo")
                        .font(.system(size: 25)).bold()
                        .padding([.bottom], 30)
                } // CLosing the Accessibility report button
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
