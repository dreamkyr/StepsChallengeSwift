//
//  URLBuilder.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit

// base url
let baseURL = "https://jsonplaceholder.typicode.com/"

struct AppErrorInfo {
    static let Domain = "https://jsonplaceholder.typicode.com" // error domain
    static let ErrorDescriptionKey = "error_description" // human-readable description
    static let ErrorKey = "error" // underlying error object
    static let ErrorUnknown = "Something went wrong, please try again later."
}

struct URLBuilder {
    
    //MARK:- Comments
    
    static var urlComments: String {get  {return baseURL + "comments"}}
}

