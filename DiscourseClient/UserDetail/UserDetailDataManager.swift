//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailDataManager: class {
    func fetchUser(userName: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    func updateUser(name: String, userName: String, completion: @escaping (Result<UpdateUserResponse?, Error>) -> ())
}
