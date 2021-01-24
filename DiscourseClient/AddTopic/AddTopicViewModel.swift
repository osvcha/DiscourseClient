//
//  AddTopicViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddTopicViewDelegate: class {
    func errorAddingTopic()
    func errorValidatingNewTopic(validateMessage: String)
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let dataManager: AddTopicDataManager

    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String) {
        /** TODO:
         Realizar la llamada addTopic sobre el dataManager.
         Si el resultado es success, avisar al coordinator
         Si la llamada falla, avisar al viewDelegate
         */
        if(title.count<20){
            
            self.viewDelegate?.errorValidatingNewTopic(validateMessage: "Title is too short (minimum is 20 characters)")
            
            return
        }
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dataManager.addTopic(title: title, raw: title, createdAt: formatter.string(from: today)) { [weak self] (result) in
            switch result {
            case .success:
                self?.coordinatorDelegate?.topicSuccessfullyAdded()
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorAddingTopic()
            }
        }
        
        
    }
}
