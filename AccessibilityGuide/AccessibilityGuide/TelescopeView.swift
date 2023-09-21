//
//  TelescopeView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 13/09/2023.
//

import SwiftUI

struct TelescopeView: View {
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
                    Text("Using the Telescope")
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
                Text("Step 2: How to use the Telescope").font(.system(size: 47)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Text("To control the map").bold()
                    .font(.system(size: 37))
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                        .padding([.bottom], -10)
                HStack {
                    Text("The Telescope should vibrate when close to any markers on the map. \n If it doesn’t vibrate, bring it to staff so they can assess any issues. \n After it vibrates, expand the telescope to reveal more information.")
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                    Button(action: testVibration){
                        Text("Test \n Vibration").font(.system(size: 40))
                            .bold()
                            .frame(width: 200, height: 130, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .padding([.trailing], 100)
                    }
                }
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Text("To take photos for accessibility reports").bold().font(.system(size: 37))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                    .padding([.bottom], 10)
                Text("If you see an accessibility issue you would like staff to be aware of, point the Telescope at the issue and push the button on the telescope to take a photo. The image will then pop up on the Tablet with instructions. ").font(.system(size: 30)).padding([.leading, .trailing])
                    .frame(width: .infinity, height: .infinity, alignment: .leading)
                    .padding([.leading], 10)
                Text("If you do not like the picture, have the Captain choose “retake.” This will close the image on the Tablet. Once the image is closed the Telescope can take another photo.").font(.system(size: 30))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding([.leading], 30)
                HStack { // OPening the Footer
                    Spacer()
                    Button(action: goToRoles){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 50))
                        Text("1. Roles")
                            .font(.system(size: 50))
                    } // Closing first button
                    Spacer()
                    Button(action: goToTelescope){
                        Text("3. How to use the Map")
                            .font(.system(size: 50))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 55))
                    } // Closing the second button
                    .padding([.leading], 500)
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
    // send some message via MQTT to vibrate
    print("Finished on my end!")
}

struct TelescopeView_Previews: PreviewProvider {
    static var previews: some View {
        TelescopeView()
    }
}
