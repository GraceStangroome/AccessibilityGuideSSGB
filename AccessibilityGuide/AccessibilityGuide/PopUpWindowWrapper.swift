//
//  PopUpWindowWrapper.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 11/10/2023.
// A wrapper for the PopUpWindow so you can call it outside of self. cases

import SwiftUI

struct PopUpWindowWrapper: UIViewControllerRepresentable {
    let popUpWindow: PopUpWindow
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return popUpWindow
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // update UIController if needed
    }
}

struct ClearView: View {
    var body: some View {
        Color.clear
    }
}
