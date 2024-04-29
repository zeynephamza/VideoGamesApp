//
//  ImagesCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Zeynep Özcan on 27.04.2024.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet var controlPages: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //bannerImage.layer.cornerRadius = 15
        //bannerImage.layer.borderWidth = 4
    }
    
}
