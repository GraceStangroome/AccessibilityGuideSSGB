//
//  HowToAccessibilityReportView.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 29/09/2023.
//

import SwiftUI

struct HowToAccessibilityReportView: View {
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
                Text("Step 4: How to make an Accessibilty Report").font(.system(size: 37)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Text("An Accessibility Report is started when either the Navigator or Captain spots something that you think this guide has missed. Making reports can help improve everyone’s understanding of accessibility!")
                    .font(.system(size: 23))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Text("Examples:").bold().font(.system(size:23))
                Text("“This floor looks slippery, but it is just glossy” \n “This room has an echo which makes it noisy”").font(.system(size:23))
                Text("Taking a picture can help others identify better areas with issues. \n Although you can make reports without a picture.").font(.system(size: 23)).padding([.leading, .trailing])
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding([.leading], 5)
                Text("Once a photo is taken, the report screen with your image will appear. This screen will ask for the general location, a general categorization of the issue, and a brief description. Submitting a report will send your answers anonymously to staff to review.").font(.system(size: 23))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding([.leading], 20)
                HStack { // OPening the Footer
                    Spacer()
                    Button(action: viewController.goToHowMapView){
                        Image(systemName: "arrow.left")
                            .font(.system(size: 32))
                        Text("3. How to use the Map")
                            .font(.system(size: 32))
                    } // Closing first button
                    Spacer()
                        .padding([.leading], -40)
                    Button(action: viewController.goToMapAndConnect){
                        Text("Go to map")
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

struct HowToAccessibilityReportView_Previews: PreviewProvider {
    static var previews: some View {
        HowToAccessibilityReportView()
    }
}
