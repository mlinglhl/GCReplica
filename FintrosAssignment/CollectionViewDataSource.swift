//
//  CollectionViewDataSource.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-16.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var sectionIndex = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let objectManager = ObjectManager.sharedInstance
        let type = objectManager.sectionNames[section]
        let objectArray = objectManager.objectDictionary[type] ?? [EquipmentObject]()
        return objectArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let objectManager = ObjectManager.sharedInstance
        let type = objectManager.sectionNames[sectionIndex]
        let objectArray = objectManager.objectDictionary[type] ?? [EquipmentObject]()
        if objectArray.count > indexPath.row {
            let object = objectArray[indexPath.row]
            cell.cellImage.image = UIImage(data: object.image! as Data)
        }
        return cell
    }
}
