//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUserUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUserName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var inputUserName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = NSLocalizedString("Insert new user name and tap button", comment: "")

        return textField
    }()
    
    
    
    lazy var updateUserButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.isEnabled = true
        
        button.setTitle("Update User Name", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 8.0
        button.tintColor = .white
        button.backgroundColor = .systemGray2
        
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        
        return button
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = .black

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal

        return userIDStackView
    }()
    
    lazy var userUsernameStackView: UIStackView = {
        let labelUserUsernameTitle = UILabel()
        labelUserUsernameTitle.text = NSLocalizedString("Username: ", comment: "")
        labelUserUsernameTitle.translatesAutoresizingMaskIntoConstraints = false

        let userUsernameStackView = UIStackView(arrangedSubviews: [labelUserUsernameTitle, labelUserUsername])
        userUsernameStackView.translatesAutoresizingMaskIntoConstraints = false
        userUsernameStackView.axis = .horizontal

        return userUsernameStackView
    }()
    
    
    lazy var userNameStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, labelUserName, inputUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal
        

        return userNameStackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        
        let buttonStackView = UIStackView(arrangedSubviews: [updateUserButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal

        return buttonStackView
    }()
    
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(userUsernameStackView)
        NSLayoutConstraint.activate([
            userUsernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userUsernameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userUsernameStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            buttonStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 8)
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
    
    @objc fileprivate func submitButtonTapped(sender: UIButton) {
        guard let newName = inputUserName.text, !newName.isEmpty else { return }
        viewModel.submitButtonTapped(name: newName)
    }
    
    fileprivate func showErrorFetchingUserDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func updateUI() {
        labelUserID.text = viewModel.labelUserIDText
        labelUserUsername.text = viewModel.labelUserUsernameText
        labelUserName.text = viewModel.labelUserNameText
        
        if let canEditName = viewModel.userCanEditName, canEditName {
            //Oculto el label del nombre y muestro el input y el botón
            labelUserName.isHidden = true
            inputUserName.text = viewModel.labelUserNameText
        } else {
            inputUserName.isHidden = true
            updateUserButton.isHidden = true
        }
    }
    
    fileprivate func showErrorUpdatingUserAlert() {
        let message = NSLocalizedString("Error updating user\nPlease try again later", comment: "")
        showAlert(message)
    }
    
    fileprivate func showUpdatingUserOkAlert() {
        let message = NSLocalizedString("User updated succesfully!", comment: "")
        showAlert(message, "OK!", "Back")
    }
    
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched() {
        updateUI()
    }

    func errorFetchingUserDetail() {
        showErrorFetchingUserDetailAlert()
    }
    
    func errorUpdatingUser() {
        showErrorUpdatingUserAlert()
    }
    
    func updatingUserOk() {
        showUpdatingUserOkAlert()
    }
    
}
