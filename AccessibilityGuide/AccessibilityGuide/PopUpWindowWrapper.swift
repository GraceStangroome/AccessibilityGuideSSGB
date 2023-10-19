//
//  PopUpWindowWrapper.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 11/10/2023.
// A wrapper for the PopUpWindow so you can call it outside of self. cases
// Also holds all the pop ups that come from MQTT messages

import SwiftUI


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
