//
//  ViewController.swift
//  ImagePicker
//
//  Created by JASJEEV on 4/1/20.
//  Copyright © 2020 Lorgarithmic Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    // Set meme attributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white /* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -1.0/* TODO: fill in appropriate Float */
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set button states
        shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        
        // Set attributes for textfields
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Setup delegates for textviews
        self.topText.delegate = self
        self.bottomText.delegate = self
        
        //Subscribe to Keyboard notifications
        subscripbeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        print("Succesfully picked image")
        
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Image Pickers
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        getImage(.camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {

         getImage(.photoLibrary)
    }
    
    
    func getImage(_ source: UIImagePickerController.SourceType) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = source
            present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func onTopEditBegin(_ sender: Any) {
        topText.text = ""
    }
    
    @IBAction func onBottomEditBegin(_ sender: Any) {
        bottomText.text = ""
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Execute the following only if the lower textfield is selected
        if(!topText.isEditing) {
        
            // Move rest of the view to make room for keyboard
            
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscripbeToKeyboardNotifications() {
        // On Keyboard show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // On keyboard hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        // Called when view will leave screen
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func save() {
            // Create the meme
            let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
            
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // Hide navigation and toolbar
        
        toolbar.isHidden = true
        navigationBar.isHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show navigation and toolbar
        toolbar.isHidden = false
        navigationBar.isHidden = false

        return memedImage
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
        let items = [memedImage]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true, completion: nil)
        
        // States for share completion
        
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print("share completed")
                self.save()
                self.dismiss(animated: true, completion: nil)
                return
            } else {
                print("cancel")
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
        
        // With assistance from: https://www.swiftdevcenter.com/uiactivityviewcontroller-tutorial-by-example/
    }
    
}

