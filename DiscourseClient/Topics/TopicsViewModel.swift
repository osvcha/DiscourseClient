//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
    func finishRefresing()
}

// ViewModel que representa un listado de topics
class TopicsViewModel {
    // Los delegate siempre con weak
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    //data manager, es al que le pido los topics, me va a contestar con un clousures en la cola main
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        
        loadTopics()
        
    }

    //numero de secciones
    func numberOfSections() -> Int {
        return 1
    }
    
    //numero de celdas
    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }
    
    //funcion que es llamada con el cellforrowatindexpath, guardapeo el indexpath.row para no salirme de los límites
    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }
    
    //se llama desde la vista cuando se ha seleccionado una celda. Avisa al coordinator
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
        
    }

    //aviso al coordinator que el botón mas ha sido pulsado
    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }
    
    //se llama cuando se ha creado un nuevo topic para volver a recuperarlos y pintarlos
    func newTopicWasCreated() {
        // TODO: Seguramente debamos recuperar de nuevo los topics del datamanager, y pintarlos de nuevo
        loadTopics()
    }
    
    func refreshLaunched() {
        loadTopics()
    }
    
    func topicWasDeleted() {
        loadTopics()
    }
    
    func loadTopics() {
        
        topicsDataManager.fetchAllTopics { [weak self] (result) in
            switch result {
            case .success(let latestTopicsResponse):
                guard let topics = latestTopicsResponse?.topicList?.topics else { return }
                self?.topicViewModels = topics.map({ topic -> TopicCellViewModel in
                    return TopicCellViewModel(topic: topic)
                })
                self?.viewDelegate?.topicsFetched()
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorFetchingTopics()
            }
        }
        
        self.viewDelegate?.finishRefresing()
        
    }
}
