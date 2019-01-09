//
//  BaseService.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit
import Alamofire

protocol BaseService: NSObjectProtocol {
    
}

extension BaseService{
    func parse( _ response: DataResponse<Any>) -> ([String: AnyObject]?, NSError?) {
        guard let result = response.value else {
            guard let error = response.error else {
                return (response: nil, error: NSError(domain: AppErrorInfo.Domain, code: 500, userInfo: [AppErrorInfo.ErrorDescriptionKey: "error unpacking response"]))
            }
            let nserror = error as NSError
            if  nserror.domain == NSURLErrorDomain {
                return (response: nil, error: nserror)
            }
            return (response: nil, error: NSError(domain: AppErrorInfo.Domain, code: 500, userInfo: [AppErrorInfo.ErrorDescriptionKey: "error unpacking response"]))
        }
        let error = response.error
        
        guard let json = result as? [String: AnyObject] else {
            guard let str = result as? [Any] else {
                var userInfo: [String:Any] = [AppErrorInfo.ErrorDescriptionKey: ""]
                if let errVal = error {
                    userInfo[AppErrorInfo.ErrorKey] = errVal
                }
                return (response: nil, error: NSError(domain: AppErrorInfo.Domain, code: 500, userInfo: userInfo))
            }
            return(["data": str as AnyObject], error: nil)
        }
        return(json, error: nil)
    }
    
    func getErrorMessage(_ error: Error?) -> String {
        let defaultLoginErrorMessage = error?.localizedDescription
        let connectionErrorMessage = "Unable to connect to network. Please try logging in again later."
        
        var loginErrorMessage = defaultLoginErrorMessage
        
        if let error = error {
            let nserror = error as NSError
            if nserror.domain == NSURLErrorDomain {
                switch (nserror.code) {
                case NSURLErrorTimedOut:
                    loginErrorMessage = connectionErrorMessage
                    break
                case NSURLErrorCannotFindHost:
                    loginErrorMessage = connectionErrorMessage
                    break
                case NSURLErrorCannotConnectToHost:
                    loginErrorMessage = connectionErrorMessage
                    break
                case NSURLErrorNetworkConnectionLost:
                    loginErrorMessage = connectionErrorMessage
                    break
                case NSURLErrorDNSLookupFailed:
                    loginErrorMessage = connectionErrorMessage
                    break
                case NSURLErrorNotConnectedToInternet:
                    loginErrorMessage = connectionErrorMessage
                    break
                default:
                    break
                }
            }
        }
        return loginErrorMessage!
    }
}
