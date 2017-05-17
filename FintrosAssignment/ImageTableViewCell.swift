//
//  ImageTableViewCell.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    var sectionIndex = 0
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
