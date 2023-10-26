//
//  ContentView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 02/08/2023.
//

import SwiftUI
import CocoaMQTT


struct ContentView: View {
    @State var viewController = ViewController()
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .leading)
                Spacer()
                VStack(alignment: .leading){
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 40))
                        .bold()
                    Text("Instructions for Getting Started")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Button(action: viewController.goToInstructions){
                    Text("Instruction Page")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 230)
                    Image(systemName: "questionmark")
                        .font(.system(size: 35))
                        .multilineTextAlignment(.trailing)
                        
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding([.leading, .trailing, .bottom])
            .foregroundColor(Color.white)
            .background(Color.red)
            VStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Welcome to the SS Great Britain.").bold()
                        .font(.system(size: 50)).font(.largeTitle)
                    Spacer()
                    Text("Table of Contents for Instructions")
                        .font(.system(size: 40)).font(.title)
                    Spacer()
                    Button(action: viewController.goToRoles) {
                        Text("1. Roles").font(.system(size: 40)).foregroundStyle(Color.black)
                    }
                    Button(action: viewController.goToTelescope) {
                        Text("2. How to use the Telescope").font(.system(size: 40)).foregroundStyle(Color.black)
                    }
                    Button(action: viewController.goToHowMapView) {
                        Text("3. How to use the Map").font(.system(size: 40)).foregroundStyle(Color.black)
                    }
                    Button(action: viewController.goToAccessibilityReport) {
                        Text("4. How to make an Accessibility Report").font(.system(size: 40)).foregroundStyle(Color.black)
                    }
                }
                Spacer()
                Button(action: viewController.goToRoles) {
                    Text("Begin going through Instructions").font(.system(size: 45))
                        .foregroundColor(Color.red)
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.red)
                        .font(.system(size: 45))
                }.padding([.top, .bottom], 30)
                Spacer()
                HStack {
                    Button(action: viewController.goToMap) {
                        Text("Skip Instructions and Go to Map")
                            .font(.system(size: 40))
                            .foregroundColor(Color.white)

                    }
                    Spacer()
                    Button(action: viewController.goToRoles){ Text("1. Roles")
                            .font(.system(size: 32))
                        Image(systemName: "arrow.right")
                            .font(.system(size:32))
                    }
                } // CLosing the Roles button
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
            } // Closing the main body
        } // Closing Vstack of everything
    } // CLosing the body
} // Closing the View


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
