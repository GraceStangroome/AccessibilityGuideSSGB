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
    let isSystem: Bool // This is asking if it's a system name image
    let isStairs: Bool
    
    @State private var isPressed = false
    // if it's stairs, the color is grey, else it's black
    // if the button has been pressed the background turns red
    var body: some View {
        Button(action: { isPressed.toggle()},
               label: {
            if imageName == "stairs" {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(3)
                    .foregroundStyle(Color.white)
                    .background(!isPressed ? Color.gray : Color.red)
            } else if isSystem {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 25, height: 25)
                    .padding(3)
                    .foregroundStyle(Color.white)
                    .background((!isPressed && !isStairs) ? Color.black : (isPressed ? Color.red : Color.gray))
            } else {
                let dynamicImageName = isPressed ? "\(imageName).red" : imageName
                Image(dynamicImageName)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 27, height: 27)
            }
            if isPressed {
                Text(buttonText)
                    .padding(.trailing, 10)
                    .bold()
                    .foregroundStyle(Color.red)
            }
        })
        .backgroundStyle(Color.black)
        .border((!isPressed && !isStairs) ? Color.black : (isPressed ? Color.red : Color.gray))
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .zIndex(isPressed ? 2 : 0) // this puts it on top when it's pressed
    }
}

struct sensoryOverlayingButton: View {
    let imageName: String
    let buttonText: String
    let colour: UInt32
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: { isPressed.toggle()},
               label: {
            if colour == 0 {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 25, height: 25)
                    .padding(3)
                    .foregroundStyle(Color.white)
                    .background(!isPressed ? Color.red : Color.black)

            } else {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 25, height: 25)
                    .padding(3)
                    .foregroundStyle(Color.white)
                    .background(Color(hex: colour))
            }
            if isPressed {
                Text(buttonText)
                    .padding(.trailing, 10)
                    .bold()
                    .foregroundStyle(colour == 0 ? Color.black : Color(hex: colour))
            }
        })
        .backgroundStyle(Color.red)
        .border((!isPressed && colour == 0) ? Color.red : (isPressed && colour == 0 ? Color.black : Color(hex: colour)))
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .zIndex(isPressed ? 2 : 0) // this puts it on top when it's pressed

    }
}


extension Color {
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}
