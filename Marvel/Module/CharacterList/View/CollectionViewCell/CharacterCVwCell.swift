//
//  CharacterCVwCell.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import UIKit
import Kingfisher

class CharacterCVwCell: UICollectionViewCell {
    //MARK: Properties
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var descriptionLbl: UILabel!
    @IBOutlet weak private var thumbnailImageVw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
        thumbnailImageVw.contentMode = .scaleAspectFill
        
    }
    
    //MARK: Methods
    func prepareCell(with character: CharacterCellData) {
        titleLbl.text = character.name
        descriptionLbl.text = character.description
        thumbnailImageVw.kf.setImage(
            with: character.imageURL,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size:  thumbnailImageVw.frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
    
    func reuse() {
        thumbnailImageVw.image = nil
        titleLbl.text = nil
        descriptionLbl.text = nil
    }
    
}
