//
//  ImagePickerDelegate.swift
//  ImagePicker
//
//  Created by JASJEEV on 4/2/20.
//  Copyright © 2020 Lorgarithmic Science. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ImageViewDelegate: NSObject, UITextFieldDelegate

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Succesfully picked image")
    }
    
    
}

