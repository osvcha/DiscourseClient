//
//  UpdateUserRequest.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UpdateUserRequest: APIRequest {
    
    typealias Response = UpdateUserResponse
    
    let name: String
    let userName: String
    
    init(name: String,
         userName: String) {
        self.name = name
        self.userName = userName
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/users/\(self.userName).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["name":self.name]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
