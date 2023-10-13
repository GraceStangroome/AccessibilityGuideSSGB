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
                Text("To control the map").bold()
                    .font(.system(size: 27))
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                        .padding([.bottom], -10)
                Text("The telescope will automatically change the map to indicate your location. \n You can also manually change the location using a location menu. \n \n When the Telescope vibrates, the marker on the map you are closest to will blink. \n  You can touch the markers to see what they indicate. \n Or you can ask the Navigator to expand the Telescope to pop up further information.The telescope will automatically change the map to indicate your location.")
                    .font(.system(size: 23))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Text("Viewing photos").bold().font(.system(size: 27))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                    .padding([.bottom], 10)
                Text("When the Captain takes a photo with the Telescope, it will appear as a pop up on the tablet. Choosing “retake” with close the pop up and erase the image, else you can choose to use the image to make an accessibility report.").font(.system(size: 23)).padding([.leading, .trailing])
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding([.leading], 5)
                HStack { // OPening the Footer
                    Spacer()
                    Button(action: viewController.goToTelescope){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 32))
                        Text("2. How to use the Telescope")
                            .font(.system(size: 32))
                    } // Closing first button
                    .padding([.leading], -20)
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
