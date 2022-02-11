//
//  CharacterCVwCell.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import UIKit

class CharacterCVwCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var thumbnailImageVw: UIImageView!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10.0
    }

}
