//
//  PopUpWindowWrapper.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 11/10/2023.
// A wrapper for the PopUpWindow so you can call it outside of self. cases
// Also holds all the pop ups that come from MQTT messages

import SwiftUI

// contains all the popups that exist
class PopUpStates: ObservableObject {
    @Published var showLowerDeckPop = false
    @Published var showDiningSaloonPop = false
}

// the wrapper itself
struct PopUpWindowWrapper: UIViewControllerRepresentable {
    let popUpWindow: PopUpWindow
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return popUpWindow
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // update UIController if needed
    }
}

// the background is a big grey box so this will get rid of it?
struct ClearView: View {
    var body: some View {
        Color.clear
    }
}

// this next bit handles the automatic popping up when mqtt stuff occurs
struct popUpViewController: View {
    @State var popUpStates: PopUpStates
    
    var body: some View {
        NavigationView {
        }
        .sheet(isPresented: $popUpStates.showLowerDeckPop) {
            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "You are now on the Lower Deck", text: "This is the last level of the ship’s interior. The SS Great Britain being launched into Bristol’s Floating Harbour on 19 July 1843. Even Prince Albert came to Bristol to celebrate."))
                .background(ClearView())
        }
        .sheet(isPresented: $popUpStates.showDiningSaloonPop) {
            PopUpWindowWrapper(popUpWindow: PopUpWindow(title: "First Class Dining Saloon", text: "There were four mealtimes for the first-class passengers: breakfast at 9am; lunch at 12pm; supper at 4pm; and dinner at 7:30pm. Would you like to join Annie Henning and Isambard Kingdom Brunel for a meal?"))
                .background(ClearView())
        }
    }
}
