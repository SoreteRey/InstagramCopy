//
//  InstaListTableViewCell.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/15/23.
//

import UIKit

class InstaListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabelTextLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var imageViewLabel: UIImageView!
    
    // MARK: - Helper Functions
    
    func configureCell(with insta: Insta) {
        nameLabelTextLabel.text = insta.InstaName
        commentTextLabel.text = insta.InstaComment
//        imageViewLabel.image = insta.imageURL
    }
}
