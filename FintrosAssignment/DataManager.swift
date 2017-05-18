//
//  DataManager.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-17.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    static let sharedInstance = DataManager()
    private override init() {}
    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "FintrosAssignment")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
////                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    func saveContext () {
        delegate.saveContext()
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
////                let nserror = error as NSError
////                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
    }

    func getEquipmentObjects() -> [EquipmentObject] {
        let context = delegate.managedObjectContext
        let request = NSFetchRequest<EquipmentObject>(entityName: "EquipmentObject")
        let sort = NSSortDescriptor(key: "dateCreated", ascending: true)
        request.sortDescriptors = [sort]
        do {
            let objectArray = try context.fetch(request)
            return objectArray
        } catch {
            return [EquipmentObject]()
        }
    }
    
    func createEquipmentObject() -> EquipmentObject {
        let equipmentObject = NSEntityDescription.insertNewObject(forEntityName: "EquipmentObject", into: delegate.managedObjectContext) as! EquipmentObject
        return equipmentObject
    }
}
