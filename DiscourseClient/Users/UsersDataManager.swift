//
//  UsersDataManager.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 20/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

/// Errores que pueden darse en el users data manager
enum UsersDataManagerError: Error {
    case unknown
}

/// Data Manager con las opraciones necesarias de este módulo
protocol UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())

}
