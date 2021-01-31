//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDeleteButtonTapped()
    
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopic()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicNumberPostsText: String?
    var topicCanDelete: Bool?
    var topicButtonIsHidden: Bool?
    
    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int
    

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        
        topicDetailDataManager.fetchTopic(id: self.topicID) { [weak self] (result) in
            switch result {
            case .success(let singleTopicResponse):
                
                if let labelTopicID = singleTopicResponse?.id {
                    self?.labelTopicIDText = String(labelTopicID)
                }
                
                self?.labelTopicNameText = singleTopicResponse?.fancyTitle
                
                if let labelTopicNumberPosts = singleTopicResponse?.postsCount {
                    self?.labelTopicNumberPostsText = String(labelTopicNumberPosts)
                }
                
                if let topicCanDelete = singleTopicResponse?.details?.canDelete {
                    self?.topicCanDelete = topicCanDelete
                    self?.topicButtonIsHidden = !topicCanDelete
                }else {
                    self?.topicCanDelete = false
                    self?.topicButtonIsHidden = true
                }
                                
                self?.viewDelegate?.topicDetailFetched()
                
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
        
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
    
    func deleteButtonTapped() {
        
        topicDetailDataManager.deleteTopic(id: self.topicID) { [weak self] (result) in
            switch result {
            case .success:
                self?.coordinatorDelegate?.topicDeleteButtonTapped()
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorDeletingTopic()
            }
        }
        
    }
}
