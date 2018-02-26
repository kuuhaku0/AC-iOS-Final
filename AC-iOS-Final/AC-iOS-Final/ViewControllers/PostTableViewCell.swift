//
//  PostTableViewCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configureCell(with post: Post) {
        postDescription.text = post.body
        postImage.kf.indicator?.startAnimatingView()
        let url = URL(string: post.imageURL!)!
        postImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "meatly_logo"), options: nil, progressBlock: nil) { (image, error, cache, url) in
            
        }
    }
}
