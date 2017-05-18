//
//  ObjectManager.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-17.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class ObjectManager: NSObject {
    var objectDictionary = [String: [EquipmentObject]]()
    static let sharedInstance = ObjectManager()
    private override init() {}
    let dataManager = DataManager.sharedInstance
    var equipmentObjectArray = [EquipmentObject]()
    var sectionNames = [String]()

    func setUp() {
        equipmentObjectArray = dataManager.getEquipmentObjects()
        if equipmentObjectArray.count < 1 {
            createObjectsWithType("Bindings")
            createObjectsWithType("Boots")
            createObjectsWithType("Gloves")
            createObjectsWithType("Hoodie")
            dataManager.saveContext()
            equipmentObjectArray = dataManager.getEquipmentObjects()
        }
        buildDictionary()
        buildSections()
    }
    
    func buildDictionary() {
        objectDictionary.removeAll()
        for object in equipmentObjectArray {
            if object.type == nil {
                object.type = "Misc"
            }
            
            let type = object.type!

            if !objectDictionary.keys.contains(type) {
                objectDictionary.updateValue([object], forKey: type)
                continue
            }
            var array = objectDictionary[type]!
            array.append(object)
            objectDictionary.updateValue(array, forKey: type)
        }
    }
    
    func buildSections() {
        let nameArray = Array(objectDictionary.keys).sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        sectionNames = nameArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    }
    
    func createObjectsWithType(_ type: String) {
        for index in 1...5 {
            let newObject = dataManager.createEquipmentObject()
            newObject.type = type
            let image = UIImage(named: "\(type)\(index)") ?? #imageLiteral(resourceName: "Bindings1")
            newObject.image = UIImagePNGRepresentation(image)! as NSData
            newObject.dateCreated = NSDate()
        }
    }
}
