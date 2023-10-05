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
                Button(action: goToInstructions){
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
                Button(action: doNothing) {
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
                Button(action: makeAccessibilityReport) {
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

func doNothing() {
    print(" ")
}


struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
