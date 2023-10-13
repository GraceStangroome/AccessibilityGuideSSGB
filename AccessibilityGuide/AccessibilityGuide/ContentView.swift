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
                .frame(width: 600, height: 150, alignment: .leading)
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
                Text("Welcome to the SS Great Britain.").bold()
                    .font(.system(size: 50)).font(.largeTitle).padding([.leading], 50).padding([.bottom, .top], 20)
                Text("Table of Contents for Instructions")
                    .font(.system(size: 40)).font(.title).padding([.leading], 20)
                VStack{
                    let steps: String = "1. Roles\n2. How to use the Telescope\n3. How to use the Map\n4. How to make an Accessibiliy Report"
                    Text(steps)
                        .font(.system(size: 40))
                        .frame(width: 900, height: 230, alignment: .leading)
                }
                Button(action: viewController.goToMap) {
                HStack(alignment: .center){
                    Text("Skip Instructions and Go to Map")
                        .font(.system(size: 40))
                        .foregroundColor(Color.red)
                        .padding()
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.red)
                        .font(.system(size: 40))
                    }
                }
                .padding()
                HStack {
                    Spacer()
                    Button(action: viewController.goToRoles){ Text("1. Roles")
                            .font(.system(size: 32))
                        Image(systemName: "arrow.right")
                            .font(.system(size:32))
                    }
                } // CLosing the Roles button
                .padding([.top], 15)
                .padding([ .bottom], 25)
                .multilineTextAlignment(.trailing)
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
