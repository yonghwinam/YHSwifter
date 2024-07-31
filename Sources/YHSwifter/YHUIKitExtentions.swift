//
//  File.swift
//  
//
//  Created by Yonghwi on 7/31/24.
//

import Foundation
import UIKit

extension UIImage {
    
    // Resize UIImage.
    public func resized(to size: CGSize) -> UIImage? {
        // Create a new context with the target size
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        
        // Draw the image into the context, resizing it
        self.draw(in: CGRect(origin: .zero, size: size))
        
        // Retrieve the resized image from the context
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Clean up the context
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
