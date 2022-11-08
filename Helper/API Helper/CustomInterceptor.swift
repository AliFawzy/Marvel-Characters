//
//  CustomInterceptor.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation
import Alamofire


class CustomInterceptor: RequestInterceptor{
    
    private var retryLimit = 3
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

        guard let hitURL = request.request?.url?.absoluteString else {return}
        
        if request.response?.statusCode == 401 && !hitURL.contains("login_check") { // token expire
            defer {TopVC.dismissToast()}
            
            DispatchQueue.main.async {
                print(request.request?.url)
            }
            
        } else if hitURL.contains("login_check") && request.response?.statusCode == 401{
            completion(.doNotRetry)
        } else if request.response?.statusCode == 500 && request.retryCount < retryLimit {
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}
