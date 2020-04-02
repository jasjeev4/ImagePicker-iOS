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
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        // Do any additional setup after loading the view.
    }

//    @IBAction func pickAnImage(_ sender: Any) {
//        let imagePicker = UIImagePickerController()
//
//        // imagePicker.delegate = imageViewDelegate
//        present(imagePicker, animated: true, completion: nil)
//
//        imagePicker.delegate =  self
//    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        print("Succesfully picked image")
        
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func onTopEditBegin(_ sender: Any) {
        topText.text = ""
    }
    
    @IBAction func onBottomEditBegin(_ sender: Any) {
        bottomText.text = ""
    }
}

