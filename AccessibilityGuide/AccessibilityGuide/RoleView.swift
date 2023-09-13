//
//  RolePage.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 13/09/2023.
//

import SwiftUI

struct RoleView: View {
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170, height: 170, alignment: .leading)

                VStack{
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 50))
                        .bold()
                        .padding([.leading], 25)
                    Text("Choosing Roles")
                        .font(.system(size: 40))
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -310)
                }
                .frame(width: 680, height: 23-0, alignment: .leading)
                Spacer()
                VStack{
                        Button(action: goToInstructions){
                            Text("Instruction Page")
                                .font(.system(size: 40))
                                .multilineTextAlignment(.trailing)
                                .padding([.leading], 40)
                                .padding([.leading, .top], 20)
                            Image(systemName: "questionmark")
                                .font(.system(size: 45))
                                .multilineTextAlignment(.trailing)
                                .padding([.top], 20)
                        } // Closing Instruciton button
                        .padding()
                    Button(action: goToMap){
                        Text("To Map")
                            .font(.system(size: 40))
                            .multilineTextAlignment(.trailing)
                        Image(systemName: "map")
                            .font(.system(size: 40))
                            .multilineTextAlignment(.trailing)
                    } // Closing the Button
                    .padding([.bottom], 40)
                    .padding([.trailing], -200)
                } // Closing the VStack of two buttons
            } // Closing Header
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding([.leading, .trailing, .bottom,])
            .foregroundColor(Color.white)
            .background(Color.red)
            
            VStack { // Opening the rest of the page
                Spacer()
                Image("Step1Roles")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 2000)
                    .padding([.top, .bottom], 30)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: goToInstructions){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 50))
                        Text("Instruction Page")
                            .font(.system(size: 50))
                    } // Closing first button
                    Spacer()
                    Button(action: goToTelescope){
                        Text("2. How to use the Telescope")
                            .font(.system(size: 50))
                            .padding([.leading], 100)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 55))
                    } // Closing the second button
                    .padding([.leading], 90)
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


func goToTelescope() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: TelescopeView())
        window.makeKeyAndVisible()
    }
}



struct RoleView_Previews: PreviewProvider {
    static var previews: some View {
        RoleView()
    }
}
