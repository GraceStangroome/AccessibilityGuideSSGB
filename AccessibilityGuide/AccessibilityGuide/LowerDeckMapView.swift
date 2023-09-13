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
                Image(systemName: "photo.fill")
                    .font(.system(size: 40))
                    .multilineTextAlignment(.leading)
                VStack{
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 40))
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -370)
                        .padding([.bottom], 10)
                    VStack{
                        Text("If the telescope buzzes, the map will tell you what you are near.")
                        .font(.system(size: 33))
                            .multilineTextAlignment(.trailing)
                        Text("You can then expand the telescope to get more information.")
                            .font(.system(size: 33))
                            .multilineTextAlignment(.trailing)
                            .padding([.leading], -45)
                    }
                    .padding([.bottom], 30)
                }
                .frame(width: 925, height: 170, alignment: .leading)
                Spacer()
                VStack{
                    HStack{
                        Text("Instruction Page")
                            .multilineTextAlignment(.trailing)
                            .padding([.leading, .bottom], 40)
                            .font(.system(size: 36))
                        Image(systemName: "questionmark")
                            .font(.system(size: 40))
                            .multilineTextAlignment(.trailing)
                            .padding([.bottom], 40)
                    }
                    HStack{
                        Text("Check to show all\ninformation points")
                            .font(.system(size: 30))
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
                        .font(.system(size: 20))
                        Text("The Ship: Lower Deck").bold()
                    Spacer()
                    Text("Touch the arrow to the right\nto see the location list")
                        .font(.system(size: 20))
                    Image(systemName: "arrowshape.left.fill")
                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .frame(width: 100.0, height: 100.0)
                        .padding([.trailing], -50)
                }
                .padding([.leading], 200)
                .frame(minWidth: 0, maxWidth: .infinity)
                Image("LowerDeck")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    .frame(width: 1200, height: 500)
                .padding()
                HStack {
                    Text("Accessibility needs are different for everyone\nclick HERE to make an accessibility report without a photo")
                        .font(.system(size: 30)).bold()
                } // CLosing the Roles button
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
