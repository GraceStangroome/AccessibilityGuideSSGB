//
//  mqttImageProcessing.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 24/10/2023.
//

import Foundation
import UIKit


func documentDirectoryPath() -> URL? {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path.first
}

func saveImgFromBytes(_ imageBytes: [UInt8]) {
    let image = getImage(imageBytes)
    if let pngData = image?.pngData(),
       let path = documentDirectoryPath()?.appendingPathComponent("newestImage.png") {
        print("Created path and png data")
        do {
            try pngData.write(to: path)
            print("Successfully saved image to \(path)")
        } catch let error {
            print("Error writing image data: \(error)")
        }
    }
}

func getImage(_ imageBytes: [UInt8]) -> UIImage? {
    print("Turning bytes into image...")
    let imageData = NSData(bytes: imageBytes, length: imageBytes.count)
    if let image = UIImage(data: imageData as Data) {
        print("Successful.")
        return image
    } else {
        print("Failed to create UIImage from the image data")
        return nil
    }
}


