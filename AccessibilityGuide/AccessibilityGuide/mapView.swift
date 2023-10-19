//
//  ssgbMap.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 02/08/2023.
//

import SwiftUI

struct mapView: View {
    @State var viewController = ViewController()
    @State private var doNothing = false
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
                        .padding([.leading], 25)
                    Text("Instructions for Getting Started")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -90)
                }
                .frame(width: 550, height: 150, alignment: .leading)
                Spacer()
                Button(action: viewController.goToInstructions){
                    Text("Instruction Page")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.trailing)
                    Image(systemName: "questionmark")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing, .top], 20)
            .foregroundColor(Color.white)
            .background(Color.red)
            VStack {
                HStack{
                    Text("Currently Viewing:" ).padding([.leading], -140)
                        .font(.system(size: 21))
                        Text("Choose a location \n or the Telescope will choose for you").bold()
                        .font(.system(size: 29))
                    Spacer()
                    Menu("Touch here to see the \nlocation list"){
                        Button(action: viewController.goToMap){Text("The Ship: Dry Dock")}
                        Button(action: viewController.goToMap){Text("The Ship: Top Deck")}
                        Button(action: viewController.goToLowerDeck){Text("The Ship: Lower Deck")}
                        Button(action: viewController.goToMap){Text("The Ship: Middle Deck")}
                        Button(action: viewController.goToMap){Text("Being Brunel: Ground")}
                        Button(action: viewController.goToMap){Text("Being Brunel: First")}
                    }
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                   .frame(width: 350, height: 75)
                   .multilineTextAlignment(.leading)

                }
                .padding([.leading], 200)
                .frame(minWidth: 0, maxWidth: .infinity)
                Button(action: { doNothing = true
                }) {
                    Text(" ")
                        .padding([.top, .bottom], 200)
                               .padding([.leading, .trailing], 500)
                               .background(
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(lineWidth: 3)
                                       .background(Color.white)
                               )
                               .foregroundColor(Color.black)
                }
                Button(action: viewController.makeAccessibilityReport) {
                    Text("Accessibility needs are different for everyone\nclick HERE to make an accessibility report without a photo")
                        .font(.system(size: 25)).bold()

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


struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
