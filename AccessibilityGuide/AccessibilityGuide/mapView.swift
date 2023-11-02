//
//  ssgbMap.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 02/08/2023.
//

import SwiftUI

struct mapView: View {
    @State var viewController = ViewController()
    @State private var doNothing = false
    @State private var showErrorPop = false
    @State private var errInfo = ""
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
                    Text("Start Your Adventure")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding([.leading], -220)
                }
                .frame(width: 550, height: 150, alignment: .leading)
                Spacer()
                Button(action: viewController.goToInstructions){
                    Text("Instruction Page")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.trailing)
                    Image(systemName: "questionmark")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing, .top], 20)
            .foregroundColor(Color.white)
            .background(Color.red)
            VStack {
                HStack{
                    Text("Currently Viewing:" ).padding([.leading], -130)
                        .font(.system(size: 21))
                    Text("Choose a location, else the map will \nautomatically change as you move").bold()
                        .font(.system(size: 29))
                    Spacer()
                    Menu("Touch \(Text("here").bold()) to see the \nlocation list"){
                        Button(action: viewController.goToTopDeck){Text("The Ship: Top Deck")}
                        Button(action: viewController.goToMiddleDeck){Text("The Ship: Middle Deck")}
                        Button(action: viewController.goToLowerDeck){Text("The Ship: Lower Deck")}
                    }
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .frame(width: 350, height: 75)
                    .multilineTextAlignment(.leading)
                    
                }
                .padding([.leading], 200)
                .frame(minWidth: 0, maxWidth: .infinity)
                Button(action: { doNothing = true
                }) {
                    Text(" ")
                        .padding([.top, .bottom], 200)
                        .padding([.leading, .trailing], 500)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .background(Color.white)
                        )
                        .foregroundColor(Color.black)
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("unacceptableProtocolVersion"))) { _ in
                    errInfo = "an unacceptable protocol version"
                    showErrorPop = true
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("identifierRejected"))) { _ in
                    errInfo = "identifier being rejected"
                    showErrorPop = true
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("serverUnavailable"))) { _ in
                    errInfo = "the server being unavailable"
                    showErrorPop = true
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("badlogOn"))) { _ in
                    errInfo = "a bad password or username"
                    showErrorPop = true
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("notAuthorized"))) { _ in
                    errInfo = "the connection not being authorised"
                    showErrorPop = true
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("reserved"))) { _ in
                    errInfo = "the connection being reserved"
                    showErrorPop = true
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("errOccured"))) { _ in
                    errInfo = "an error occuring. This is likely due to the broker being offline" // this is true from testing
                    showErrorPop = true
                }
                .sheet(isPresented: $showErrorPop) {
                    PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "Error", text: "A problem connecting to the broker occured due to \(errInfo). Please close the app completely and try again. If this persists please contact a member of staff."))
                }
                HStack{
                    Text("Accessibility needs are different for everyone. Click")
                    Button(action: viewController.makeAccessibilityReport) {
                        Text("HERE  ")
                            .font(.system(size: 25)).bold().foregroundColor(Color.red).background(Color.white)
                    } // CLosing the Accessibility report button
                    .mask {
                                RoundedRectangle(cornerRadius: 5)
                    }
                    Text("to make an accessibility report")
                }
                .font(.system(size: 25)).bold()
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 90)
                .foregroundColor(Color.white)
                .background(Color.red)
                //.padding()
        
            } // Closing the main body
        } // Closing the entire screen
    } // CLosing the body
} // Closing the View


struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView()
    }
}
