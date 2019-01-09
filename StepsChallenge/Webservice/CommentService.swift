//
//  CommentService.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit
import Alamofire

protocol CommentService: BaseService {
    func webServiceGetError(receivedError: String)
    func webServiceGetResponse(comments: [Comment])
}

extension CommentService {
    func fetchComments(firstNum: Int, lastNum: Int, page: Int) {
        var params = [String: Any]()
        params["postId_gte"] = firstNum
        params["postId_lte"] = (lastNum == 1) ? 500 : lastNum
        params["_page"] = page
        params["_limit"] = kPageLimit
        
        Alamofire.request(URLBuilder.urlComments, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            let (parsedResult, parsedError) = self.parse(response)
            if let error = parsedError {
                self.webServiceGetError(receivedError: self.getErrorMessage(error))
            } else if let parsedResult = parsedResult {
                guard let _ = parsedResult[AppErrorInfo.ErrorKey] else {
                    var comments = [Comment]()
                    if let array = parsedResult["data"] as? NSArray {
                        for comment in array {
                            comments.append(Comment.init(dict: comment as! [String: Any]))
                        }
                    }
                    self.webServiceGetResponse(comments: comments)
                    return
                }
                self.webServiceGetError(receivedError: AppErrorInfo.ErrorUnknown)
            }
        }
    }
}
