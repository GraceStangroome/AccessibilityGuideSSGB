//
//  OverlayingButtons.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 20/10/2023.
//

import UIKit
import SwiftUI

struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}
 
 
extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}

struct overlayingButton: View {
    let imageName: String
    let buttonText: String
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: { isPressed.toggle()},
               label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(3)
                .foregroundStyle(Color.white)
                .background(!isPressed ? Color.black : Color.red)
            if isPressed {
                Text(buttonText)
                    .padding(.trailing, 10)
                    .bold()
                    .foregroundStyle(Color.red)
            }
        })
        .backgroundStyle(Color.black)
        .border(!isPressed ? Color.black : Color.red)
        .background(Color.white)
        .frame(maxWidth: .infinity)
    }
}
