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
                    Text("Instructions")
                        .font(.system(size: 30))
                        .padding(.leading, -245)
                }
                .multilineTextAlignment(.leading)
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
                Text("Step 1: Choose a role:").font(.system(size: 37)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                HStack { // first row of instructions
                    Spacer()
                    VStack {
                        Text("Captain").font(.system(size: 30))
                        Image("characters-07").resizable().aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                    VStack {
                        Image("characters-01").resizable().aspectRatio(contentMode: .fit)
                        Text("Holds the Tablet").font(.system(size: 20))
                    }
                    Spacer()
                    VStack {
                        Image("characters-06").resizable().aspectRatio(contentMode: .fit)
                        Text("The map will change as you explore \nand tell you about sensory triggers \nand potential safety hazards").multilineTextAlignment(.center).font(.system(size: 20))
                    }
                    Spacer()
                    VStack {
                        Image("characters-05").resizable().aspectRatio(contentMode: .fit)
                        Text("If you notice something that \nbothers the Navigator, you can \nmake an accessibility report").multilineTextAlignment(.center).font(.system(size: 20))
                    }
                    Spacer()
                } // end of first row
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                HStack { // start of second row
                    Spacer()
                    VStack {
                        Text("Navigator").font(.system(size: 30))
                        Image("characters-08").resizable().aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                    VStack {
                        Image("characters-02").resizable().aspectRatio(contentMode: .fit)
                        Text("Holds the Telescope").font(.system(size: 20))
                    }
                    Spacer()
                    VStack {
                        Image("characters-04").resizable().aspectRatio(contentMode: .fit)
                        Text("If the telescope is collapsed, \nand you push the button, \na fun fact pops up on the tablet").multilineTextAlignment(.center).font(.system(size: 20))
                    }
                    Spacer()
                    VStack {
                        Image("characters-03").resizable().aspectRatio(contentMode: .fit)
                        Text("Extending the telescope and pushing \nthe button takes pictures that can \nbe added to the Captain's report").multilineTextAlignment(.center).font(.system(size: 20))
                    }
                    Spacer()
                }
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
