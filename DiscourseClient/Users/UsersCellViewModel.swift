//
//  UsersCellViewModel.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 20/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserCellViewDelegate: class {
    func userImageDownloaded()
}

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    var userImageData: Data?
    
    weak var viewDelegate: UserCellViewDelegate?
    
    
    
    init(user: User) {
        self.user = user
        self.textLabelText = self.user.name
        
        
        downloadUserImage()
    }
    
    private func downloadUserImage() {
        
        var avatarTemplate: String = ""
        if let avatarTemplateUser = self.user.avatarTemplate{
            let avatarTemplateSize = avatarTemplateUser.replacingOccurrences(of: "{size}", with: "200")
            avatarTemplate = "https://mdiscourse.keepcoding.io"+avatarTemplateSize
        }
        
        guard let userImageURL: URL = URL(string: avatarTemplate) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let userImageData: Data = try? Data(contentsOf: userImageURL) else {return}
            //let userImage: UIImage? = UIImage(data: userImageData)
            
            DispatchQueue.main.async { [weak self] in
                self?.userImageData = userImageData
                self?.viewDelegate?.userImageDownloaded()
            }
  
        }
    }
    
}
