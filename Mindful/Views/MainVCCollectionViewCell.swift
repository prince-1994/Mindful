//
//  MainVCCollectionViewCell.swift
//  Mindful
//
//  Created by Yuvraj Sahu on 17/04/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class MainVCCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setValues(text : String ,backgroundColor : UIColor){
        nameLabel.text = text
        nameLabel.backgroundColor = UIColor.clear
        self.backgroundColor = backgroundColor
    }
}
