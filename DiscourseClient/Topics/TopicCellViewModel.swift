//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    let topic: Topic
    var textLabelText: String?
    var topicClosed: Bool?
    
    init(topic: Topic) {
        self.topic = topic
        self.textLabelText = self.topic.fancyTitle
        self.topicClosed = self.topic.closed
        // TODO: Asignar textLabelText, el título del topic
    }
}
