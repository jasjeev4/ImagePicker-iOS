//
//  ViewController.swift
//  ImagePicker
//
//  Created by JASJEEV on 4/1/20.
//  Copyright © 2020 Lorgarithmic Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    let imagePickerDelegate = ImagePickerDelegate()
    
    @IBOutlet weak var imageView: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self.imagePickerDelegate
        
        // imagePicker.delegate = imageViewDelegate
        present(imagePicker, animated: true, completion: nil)
    }
    
}

