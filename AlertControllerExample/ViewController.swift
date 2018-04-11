//
//  ViewController.swift
//  AlertControllerExample
//
//  Created by Hoàng Khánh on 4/7/18.
//  Copyright © 2018 Hoàng Khánh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnShowAlert: UIButton!
    var alertController:UIAlertController?
    var pickerController:UIImagePickerController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func btnShowAlert(_ sender: Any) {
        alertController = UIAlertController(title: "Take image", message: "Choose image", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.openCamera()
        })
        let photoAction = UIAlertAction(title: "Your photo", style: .default, handler: { (action) in
            self.openPhoto()
        })
        alertController?.addAction(cameraAction)
        alertController?.addAction(photoAction)
        alertController?.view.tintColor = UIColor.orange
        self.present(alertController!, animated: true) {
            
        }
        
    }
    
    func openCamera() {
        pickerController = UIImagePickerController()
        if(UIImagePickerController.isSourceTypeAvailable(.camera) == false) {
            return
        }
        pickerController?.delegate = self
        pickerController?.allowsEditing = true
        pickerController?.sourceType = .camera
        self.present(pickerController!, animated: true) {
            
        }
    }
    
    func openPhoto() {
        pickerController = UIImagePickerController()
        pickerController?.delegate = self
        pickerController?.allowsEditing = true
        pickerController?.sourceType = .photoLibrary
        self.present(pickerController!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        picker.dismiss(animated: true, completion: {
            let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicatorView.color = UIColor.gray
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.frame = self.view.frame
            activityIndicatorView.center = self.view.center
            activityIndicatorView.startAnimating()
            DispatchQueue.global().async {
                for index in 1...100000 {
                    print(index)
                }
                DispatchQueue.main.async {
                    self.imageView.image = image
                    activityIndicatorView.stopAnimating()
                }
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.verifyInformation()
    }

    func verifyInformation() {
        alertController = UIAlertController(title: "Verification", message: "Enter name or password", preferredStyle: .alert)
        alertController?.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Enter email"
            textField.keyboardType = .emailAddress
        })
        
        alertController?.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(alert) in
            let textFieldEmail = self.alertController!.textFields![0] as UITextField
            let textFieldPassword = self.alertController!.textFields![1] as UITextField
            if(textFieldEmail.text != "admin" || textFieldPassword.text != "123456") {
                self.verifyInformation()
            }
        })
        alertController?.addAction(okAction)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

