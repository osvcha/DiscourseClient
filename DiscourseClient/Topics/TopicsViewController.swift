//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {
    
    var refreshControl = UIRefreshControl()
    
    //creo la tabla, registro celdas, delegate, datasource, etc.
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    let viewModel: TopicsViewModel
    
    //inicializador custom y le paso el viewmodel
    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    //este solo se llamaría si tuvieramos storyboard, como no tenemos no se va a dar el caso, le metemos un fatalerror y a vivir
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //no se llama si tuvieramos storyboard, al constuir nosotros la vista, lo necesitamos para añadir la tabla a la vista
    //también le metemos los constraints y el botón de la navbar
    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])


        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        
    }
    
    //avisamos al viewmodel que la vista se ha cargado
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    //aviso al viewmodel que se ha pulsado el botón
    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.refreshLaunched()
    }
    
    //método de utilidad para mostrar alertas, el showAlert está definido en una extensión de uiviewController
    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

//implementación del datasource
extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    //después del dequeue de la celda, se la pedimos al viewmodel
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }

        fatalError()
    }
}

//delegate, aviso al viewmodel de los eventos, por ejemplo, cuando se ha seleccionado una celda
extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

//implementación del TopicsViewDelegate. Me permite comunicar el viewmodel con la vista.
//De esa manera, el viewmodel puede avisar a la vista que ya se han cargado los datos, para que haga el reloaddata()
//y cuando ha avido un error
extension TopicsViewController: TopicsViewDelegate {
    
    func topicsFetched() {
        tableView.reloadData()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
    
    func finishRefresing() {
        refreshControl.endRefreshing()
    }
}
