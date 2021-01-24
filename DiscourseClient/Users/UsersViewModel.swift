//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 20/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

/// ViewModel representando un listado de usuarios
class UsersViewModel {
    
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    
    let usersDataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    
    func viewWasLoaded() {
        
        loadUsers()
        
    }
    
    
    //numero de secciones
    func numberOfSections() -> Int {
        return 1
    }
    
    //numero de celdas
    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }
    
    //se llama desde la vista cuando se ha seleccionado una celda. Avisa al coordinator
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user)
        
    }
    
    func userWasupdated() {
        loadUsers()
    }
    
    func loadUsers(){
        
        usersDataManager.fetchAllUsers { [weak self] (result) in
            switch result {
            case .success(let usersResponse):
                guard let users = usersResponse?.directoryItems else {return}
                self?.userViewModels = users.map({ directoryItem -> UserCellViewModel in
                    return UserCellViewModel(user: directoryItem.user )
                })
                self?.viewDelegate?.usersFetched()
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorFetchingUsers()
            }
        }
    
    }
}

