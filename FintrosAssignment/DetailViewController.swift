//
//  DetailViewController.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-17.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let picker = UIImagePickerController()

    var equipmentObject: EquipmentObject?
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        if let equipmentObject = equipmentObject {
            if equipmentObject.image != nil {
                let image = UIImage(data: equipmentObject.image! as Data)
                imageView.image = image
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if equipmentObject == nil {
            equipmentObject = DataManager.sharedInstance.createEquipmentObject()
            equipmentObject!.type = "Misc"
        }
        equipmentObject!.image = UIImagePNGRepresentation(imageView.image!)! as NSData
        DataManager.sharedInstance.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
}
