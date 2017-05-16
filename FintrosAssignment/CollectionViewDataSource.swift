//
//  CollectionViewDataSource.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-16.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.cellImage.image = #imageLiteral(resourceName: "Boots4")
        return cell
    }
}
