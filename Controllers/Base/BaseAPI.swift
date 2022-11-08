//
//  BaseAPI.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation


class BaseAPI {
    
    class func CancelRequests() {
        ApiHandler.cancelRequests()
    }
    
    // using GetMoviesList Model
    class func GetCharactersList(offset: Int,completion:@escaping(_ status: Int, _ response: GetCharacters?, _ erorr: ResponseError?) -> Void) {
        let timeStamp = "\(getCurrentTimeStamp())"
        
        let hash = MD5("\(timeStamp)\(Constants.private_key)\(Constants.public_key)")
        let characters_URL = Constants.domain + Constants.characters + "?apikey=\(Constants.public_key)&ts=\(timeStamp)&hash=\(hash ?? "")&offset=\(offset)"
        print("characters_URL \(characters_URL)")
        ApiHandler.performGet(URLString: characters_URL, params: nil, headers: Constants().defaultHeader, authorization: nil) { (status: Int, response: GetCharacters?, error: ResponseError?) in

            switch status {
            case 0: // Error model problem ex: type mismatch
                completion(0, response, error)
            case 1: // Success with normal response model
                completion(1, response, error)
            case 2: // Error with error model
                completion(2, response, error)
            default : // -1 No Internet Connections
                completion(-1,nil, nil)
            }
        }
    }
    
}
