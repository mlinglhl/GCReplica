//
//  DetailViewController.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-17.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let picker = UIImagePickerController()
    var delegate: ReloadDataProtocol!
    var equipmentObject: EquipmentObject?
    
    @IBOutlet weak var deleteSwitch: UISwitch!
    @IBOutlet var typePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var newTypeTextField: UITextField!
    @IBOutlet weak var useExistingTypeSwitch: UISwitch!
    @IBOutlet weak var typePickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        typePickerView.dataSource = self
        typePickerView.delegate = self
        newTypeTextField.isHidden = true
        newTypeTextField.delegate = self
        newTypeTextField.transform = CGAffineTransform(scaleX: 0, y: 1)
        deleteSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        if equipmentObject == nil {
            deleteSwitch.isEnabled = false
            deleteLabel.alpha = 0.3
        }
        
        useExistingTypeSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        if let equipmentObject = equipmentObject {
            if equipmentObject.image != nil {
                let image = UIImage(data: equipmentObject.image! as Data)
                imageView.image = image
            }
            let index = ObjectManager.sharedInstance.sectionNames.index(of: equipmentObject.type!)
            typePickerView.selectRow(index!, inComponent: 0, animated: false)
        }
    }

    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ObjectManager.sharedInstance.sectionNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ObjectManager.sharedInstance.sectionNames[row]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func useExistingTypeSwitchChanged(_ sender: UISwitch) {
        newTypeTextField.isHidden = false
        typePickerView.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            if sender.isOn {
                self.typePickerView.transform = CGAffineTransform.identity
                self.newTypeTextField.transform = CGAffineTransform(scaleX: 0, y: 1)
            } else {
                self.typePickerView.transform = CGAffineTransform(scaleX: 1, y: 0)
                self.newTypeTextField.transform = CGAffineTransform.identity
            }
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.newTypeTextField.isHidden = sender.isOn
            self.typePickerView.isHidden = !sender.isOn
        })
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let objectManager = ObjectManager.sharedInstance
        var type = newTypeTextField.text ?? ""
        if type == "" {
            type = "Misc"
        }
        if useExistingTypeSwitch.isOn {
            let index = typePickerView.selectedRow(inComponent: 0)
            if objectManager.sectionNames.count > index {
                type = objectManager.sectionNames[index]
            }
        }
        
        if equipmentObject == nil {
            equipmentObject = DataManager.sharedInstance.createEquipmentObject()
            equipmentObject!.dateCreated = NSDate()
            objectManager.equipmentObjectArray.append(equipmentObject!)
        } else {
            if equipmentObject!.type != type {
                equipmentObject?.dateCreated = NSDate()
            }
        }
            equipmentObject!.type = type
            equipmentObject!.image = UIImageJPEGRepresentation(imageView.image!, 1.0)! as NSData

        if deleteSwitch.isOn {
            DataManager.sharedInstance.persistentContainer.viewContext.delete(equipmentObject!)
        }

        DataManager.sharedInstance.saveContext()
        delegate.reloadData(type: type)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
}
