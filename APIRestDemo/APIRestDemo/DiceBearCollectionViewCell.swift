//
//  DiceBearCollectionViewCell.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 25/1/24.
//

import UIKit

final class DiceBearCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        avatar.layer.cornerRadius = 10
    }
    
    //Limpia la instancia de la cell
    override func prepareForReuse() {
        avatar.image = nil
    }
}
