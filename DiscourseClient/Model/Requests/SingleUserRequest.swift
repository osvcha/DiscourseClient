//
//  SingleUserRequest.swift
//  DiscourseClient
//
//  Created by Osvaldo Chaparro on 24/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct SingleUserRequest: APIRequest {
    
    typealias Response = SingleUserResponse
    
    let userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/users/\(self.userName).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
