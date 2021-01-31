//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 20/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
            
            viewModel.viewDelegate = self
            
            if let userImageData = viewModel.userImageData, let userImage: UIImage = UIImage(data: userImageData) {
                imageView?.image = userImage
            }
        
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
  
}

extension UserCell: UserCellViewDelegate {
    func userImageDownloaded() {
        
        guard let userImageData = viewModel?.userImageData else {return}
        let userImage: UIImage? = UIImage(data: userImageData)
        imageView?.image = userImage
        setNeedsLayout()
    }
    
    
}
