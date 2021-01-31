//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTopicNumberPosts: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteTopicButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.isEnabled = true
        
        button.setTitle("Delete Topic", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 8.0
        button.tintColor = .white
        button.backgroundColor = .systemGray2
        
        button.addTarget(self, action: #selector(deleteTopicAction), for: .touchUpInside)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        
        return button
    }()

    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal

        return topicIDStackView
    }()

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal

        return topicNameStackView
    }()
    
    lazy var topicNumberPostsStackView: UIStackView = {
        let labelTopicNumberPostsTitle = UILabel()
        labelTopicNumberPostsTitle.text = NSLocalizedString("Number of Posts: ", comment: "")
        labelTopicNumberPostsTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicNumberPostsStackView = UIStackView(arrangedSubviews: [labelTopicNumberPostsTitle, labelTopicNumberPosts])
        topicNumberPostsStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNumberPostsStackView.axis = .horizontal

        return topicNumberPostsStackView
    }()
    
    lazy var topicDeleteButtonStackView: UIStackView = {
        let topicDeleteButtonStackView = UIStackView(arrangedSubviews: [deleteTopicButton])
        topicDeleteButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        topicDeleteButtonStackView.axis = .horizontal

        return topicDeleteButtonStackView
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicNumberPostsStackView)
        NSLayoutConstraint.activate([
            topicNumberPostsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNumberPostsStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicDeleteButtonStackView)
        NSLayoutConstraint.activate([
            topicDeleteButtonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicDeleteButtonStackView.topAnchor.constraint(equalTo: topicNumberPostsStackView.bottomAnchor, constant: 8)
        ])

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc func deleteTopicAction(sender: UIButton) {
        let btnTag: UIButton = sender
        if btnTag.tag == 1 {
            viewModel.deleteButtonTapped()
        }
    }


    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorDeletingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error deleting topic\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        labelTopicNumberPosts.text = viewModel.labelTopicNumberPostsText
        if let topicButtonIsHidden = viewModel.topicButtonIsHidden {
            deleteTopicButton.isHidden = topicButtonIsHidden
            if(!topicButtonIsHidden) {
                deleteTopicButton.backgroundColor = .red } else {
                    deleteTopicButton.backgroundColor =  .systemGray2
            }
        }
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched() {
        updateUI()
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
    
    func errorDeletingTopic(){
        showErrorDeletingTopicDetailAlert()
    }
}
