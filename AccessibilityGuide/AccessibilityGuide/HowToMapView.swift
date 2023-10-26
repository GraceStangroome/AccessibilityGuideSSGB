//
//  HowToMapView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 29/09/2023.
//

import SwiftUI

struct HowToMapView: View {
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
                    Text("Using the Telescope")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -230)
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
                Text("Step 3: How to use the Map").font(.system(size: 37)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                Text("To control the map").bold()
                    .font(.system(size: 27))
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                Spacer()
                Text("The map will automatically change to indicate your location. You can also temporarily change your location from a menu or view all sensory triggers and potential safety hazards by checking a box: both will appear in the upper right side of the screen.")
                    .multilineTextAlignment(.leading).font(.system(size: 25)).padding([.leading, .trailing], 20)
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                Text("Making an Accessibility Reports").bold().font(.system(size: 27))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Spacer()
                Text("When the Captain takes a photo with the Telescope, it will appear as a pop up on the tablet in an accessibility report form. Select where the issue is located and what icon best describes the issue.")
                    .multilineTextAlignment(.leading).font(.system(size: 25)).padding([.leading, .trailing], 19)
                Spacer()
                Text("You can also make accessibility reports without including a photo, by tapping a button that will appear at the bottom of the screen.")
                    .multilineTextAlignment(.leading).font(.system(size: 24)).padding([.leading, .trailing], 15)
                Spacer()
                HStack { // OPening the Footer
                    Button(action: viewController.goToTelescope){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 32))
                        Text("2. How to use the Telescope")
                            .font(.system(size: 32))
                    } // Closing first button
                    Spacer()
                    Button(action: viewController.goToAccessibilityReport){
                        Text("4. How to make an Accessibility report")
                            .font(.system(size: 32))
                            .multilineTextAlignment(.leading)
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

struct HowToMapView_Previews: PreviewProvider {
    static var previews: some View {
        HowToMapView()
    }
}
