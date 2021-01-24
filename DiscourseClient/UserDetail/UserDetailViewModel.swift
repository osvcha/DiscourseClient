//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func errorFetchingUserDetail()
    func errorUpdatingUser()
    func updatingUserOk()
}

class UserDetailViewModel {
    var labelUserIDText: String?
    var labelUserNameText: String?
    var labelUserUsernameText: String?
    var userCanEditName: Bool?
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let userName: String
    

    init(userName: String, userDetailDataManager: UserDetailDataManager) {
        self.userName = userName
        self.userDetailDataManager = userDetailDataManager
    }

    func viewDidLoad() {
        
        userDetailDataManager.fetchUser(userName: self.userName) { [weak self] (result) in
            switch result {
            case .success(let singleUserResponse):
                
                if let labelUserID  = singleUserResponse?.user?.id {
                    self?.labelUserIDText = String(labelUserID)
                }
                
                self?.labelUserNameText = singleUserResponse?.user?.name
                
                self?.labelUserUsernameText = singleUserResponse?.user?.username
                
                if let userCanEditName = singleUserResponse?.user?.canEditName {
                    self?.userCanEditName = userCanEditName
                }else {
                    self?.userCanEditName = false
                }
                
                self?.viewDelegate?.userDetailFetched()
                    
                
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorFetchingUserDetail()
            }
        }
        
    }

    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }
    
    func loadData() {
        
    }
    
    func submitButtonTapped(name: String) {
        
        print(name)
        print(userName)
        
        userDetailDataManager.updateUser(name: name, userName: userName) { [weak self] (result) in
            switch result {
            case .success:
                self?.viewDelegate?.updatingUserOk()
                break
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorUpdatingUser()
                break
            }
        }
        
        
    }
    
}
