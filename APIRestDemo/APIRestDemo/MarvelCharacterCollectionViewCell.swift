//
//  MarvelCharacterCollectionViewCell.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 1/2/24.
//

import UIKit

final class MarvelCharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
      
    }

    override func prepareForReuse() {
        thumbnail.image = nil
        nameLabel.text = nil
    }
}
