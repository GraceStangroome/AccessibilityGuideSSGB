//
//  TelescopeView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 13/09/2023.
//

import SwiftUI

struct TelescopeView: View {
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
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -245)
                }
                .frame(width: 550, height: 0, alignment: .leading)
                Spacer()
                VStack{
                    Button(action: viewController.goToInstructions){
                            Text("Instruction Page")
                                .font(.system(size: 30))
                                .multilineTextAlignment(.trailing)
                                .padding([.leading], 40)
                                .padding([.leading, .top], 20)
                            Image(systemName: "questionmark")
                                .font(.system(size: 45))
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
                    .padding([.bottom], 0)
                    .padding([.trailing], -200)
                } // Closing the VStack of two buttons
            } // Closing Header
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding([.leading, .trailing, .bottom,])
            .foregroundColor(Color.white)
            .background(Color.red)
            
            VStack { // Opening the rest of the page
                Text("Step 2: How to use the Telescope").font(.system(size: 37)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                Text("Feel free to extend and collapse the telescope. Maybe even use it to gesture at things? However, if you push the button, different things will happen depending on the state of the telescope.").multilineTextAlignment(.leading).font(.system(size: 23)).padding([.leading, .trailing], 23)
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                Text("To get fun fact pop-ups").bold().font(.system(size: 27)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 25)
                Spacer()
                Text("When \(Text("EXTENDED").bold()) and the button is pressed, this will cause a fun fact to pop-up related to the room you and the Captain are currently in").font(.system(size: 23)).padding([.leading, .trailing], 23)
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                Text("To take photos for accessibility reports").bold().font(.system(size: 27))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Spacer()
                Text("If you see an accessibility issue you would like staff to be aware of, point the \(Text("COLLAPSED").bold()) Telescope at the issue and push the button to take a photo. The image and accessibility report form will then pop up on the Tablet. If you do not like the picture, push the button again to retake it. ").font(.system(size: 23)).padding([.leading, .trailing], 20)
                Spacer()
                HStack { // OPening the Footer
                    Spacer()
                    Button(action: viewController.goToRoles){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 32))
                        Text("1. Roles")
                            .font(.system(size: 32))
                    } // Closing first button
                    .padding([.leading], -100)
                    Spacer()
                    Button(action: viewController.goToHowMapView){
                        Text("3. How to use the Map")
                            .font(.system(size: 32))
                            .multilineTextAlignment(.leading)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 32))
                    } // Closing the second button
                    .padding([.leading], 400)
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

func testVibration() {
    print("Beep Boop testing vibration!")
    let mqttmanager = ViewController()
    mqttmanager.publish(topic: "messagesFromiPad", content: "vibrate")
    print("Finished on my end!")
}

struct TelescopeView_Previews: PreviewProvider {
    static var previews: some View {
        TelescopeView()
    }
}
