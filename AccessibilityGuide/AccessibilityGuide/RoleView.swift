//
//  RolePage.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 13/09/2023.
//

import SwiftUI

struct RoleView: View {
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
                    Text("Choosing Roles")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -90)
                }
                .frame(width: 570, height: 100, alignment: .leading)
                Spacer()
                VStack{
                    Button(action: viewController.goToInstructions){
                            Text("Instruction Page")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.trailing)
                                .padding([.leading, .top], 20)
                            Image(systemName: "questionmark")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.trailing)
                                .padding([.top], 20)
                        } // Closing Instruciton button
                        .padding()
                    Button(action: viewController.goToMap){
                        Text("To Map")
                            .font(.system(size: 30))
                            .multilineTextAlignment(.trailing)
                        Image(systemName: "map")
                            .font(.system(size: 30))
                            .multilineTextAlignment(.trailing)
                    } // Closing the Button
                    .padding([.bottom], 40)
                    .padding([.trailing], -150)
                } // Closing the VStack of two buttons
            } // Closing Header
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding([.leading, .trailing])
            .foregroundColor(Color.white)
            .background(Color.red)
            
            VStack { // Opening the rest of the page
                Spacer()
                Image("Step1Roles")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    .frame(width: 1000, height: 500)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: viewController.goToInstructions){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 32))
                        Text("Instruction Page")
                            .font(.system(size: 32))
                    } // Closing first button
                    .padding([.leading], -290)
                    Spacer()
                    Button(action: viewController.goToTelescope){
                        Text("2. How to use the Telescope")
                            .font(.system(size: 32))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 32))
                    } // Closing the second button

                } // Closing the footer
                .padding([.top], 15)
                .multilineTextAlignment(.trailing)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
            } // Closing the main body
        } // Closing Vstack of everything
    } // CLosing the body
} // Closing the View



struct RoleView_Previews: PreviewProvider {
    static var previews: some View {
        RoleView()
    }
}
