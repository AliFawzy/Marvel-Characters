//
//  AlamoCodableAPIHandel.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//


import UIKit
import Alamofire

class ApiHandler{
    
    private static func checkConnection() -> Bool {
        guard let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com") else {return false}
        return reachabilityManager.isReachable
    }
    
    class func cancelRequests() {
        AF.session.getAllTasks { (tasks) in
            tasks.forEach {$0.cancel() }
        }
    }
    
    class func performGet<T: Codable>(URLString: String, params: [String: Any]?, headers: [String:String]? = nil, authorization:String? = nil, isAuthEqualNil: Bool = true, completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void) {
        
        if checkConnection() {
            let escapedString = URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            //            let Headers = ApiHandler.checkHeaders(headers: headers, authorization: authorization)
            var newHeaders: HTTPHeaders?
            
            if authorization == nil {
                if !isAuthEqualNil { // for make CustomInterceptor work
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(String(describing: authorization))"])
                } else {
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: nil)
                }
            } else {
                newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(authorization!)"])
            }
            
            AF.request(escapedString, parameters: params, encoding: URLEncoding.default, headers: newHeaders, interceptor: CustomInterceptor())
                .validate(statusCode: 200...400)
                .responseData { (response) in
                    if response.response?.statusCode != 401 {
                        handleResponse(response: response, completed: completed)
                    } else {
                        // Token Expire login again
                    }
                }
        }else{
            ApiHandler.checkInternetConnection(completed: completed)
        }
    }
    
    class func performPost<P:Codable, T:Codable>(httpMethod: HTTPMethod = .post, URLString: String, params: P?, headers: [String:String]? = nil, authorization:String? = nil, isAuthEqualNil: Bool = true, completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void) {
        
        if checkConnection() {
            
            let escapedString = URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            var newHeaders: HTTPHeaders?
            
            if authorization == nil {
                if !isAuthEqualNil { // for make CustomInterceptor work
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(String(describing: authorization))"])
                } else {
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: nil)
                }
            } else {
                newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(authorization!)"])
            }
            
            
            // Call with codable model
            AF.request(escapedString, method: httpMethod, parameters: params, encoder: JSONParameterEncoder.default, headers: newHeaders, interceptor: CustomInterceptor())
                .validate(statusCode: 200...401)
                .responseData { (response) in

                    if response.response?.statusCode != 401 {
                        handleResponse(response: response, completed: completed)
                    } else {
                        // Token Expire login again
                        TopVC.showToast("Invalid credentilals", position: .top)
                        TopVC.dismissToast()
                    }
                }
        }else{
            ApiHandler.checkInternetConnection(completed: completed)
        }
    }
    
    
    class func performDelete<T: Codable>(httpMethod: HTTPMethod = .delete, URLString: String, params: [String: Any]?, headers: [String:String]? = nil, authorization:String? = nil, isAuthEqualNil: Bool = true, completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void) {
        
        if checkConnection() {
            let escapedString = URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            //            let Headers = ApiHandler.checkHeaders(headers: headers, authorization: authorization)
            var newHeaders: HTTPHeaders?
            
            if authorization == nil {
                if !isAuthEqualNil { // for make CustomInterceptor work
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(String(describing: authorization))"])
                } else {
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: nil)
                }
            } else {
                newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(authorization!)"])
            }
            
            AF.request(escapedString, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: newHeaders, interceptor: CustomInterceptor())
                .validate(statusCode: 200...400)
                .responseData { (response) in
                    if response.response?.statusCode != 401 {
                        handleResponse(response: response, completed: completed)
                    } else {
                        // Token Expire login again
                    }
                }
        }else{
            ApiHandler.checkInternetConnection(completed: completed)
        }
        
    }
    
    
    class func performPut<P:Codable, T:Codable>(httpMethod: HTTPMethod = .put, URLString: String, params: P?, headers: [String:String]? = nil, authorization:String? = nil, isAuthEqualNil: Bool = true, completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void) {
        
        if checkConnection() {
            
            let escapedString = URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            //            let headers = ApiHandler.checkHeaders(headers: headers, authorization: authorization)
            var newHeaders: HTTPHeaders?
            
            if authorization == nil {
                if !isAuthEqualNil { // for make CustomInterceptor work
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(String(describing: authorization))"])
                } else {
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: nil)
                }
            } else {
                newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(authorization!)"])
            }
            
            // Call with codable model
            AF.request(escapedString, method: httpMethod, parameters: params, encoder: JSONParameterEncoder.default, headers: newHeaders, interceptor: CustomInterceptor())
                .validate(statusCode: 200...400)
                .responseData { (response) in
                    if response.response?.statusCode != 401 {
                        handleResponse(response: response, completed: completed)
                    } else {
                        // Token Expire login again
                    }
                }
        }else{
            ApiHandler.checkInternetConnection(completed: completed)
        }
        
    }
    
    class func uploadPost<T:Codable>(httpMethod: HTTPMethod = .post, URLString: String, params: [String:String], imageModelKey: String?, images: [UIImage]?, headers: [String:String]? = nil, authorization:String? = nil, isAuthEqualNil: Bool = true, completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void) {
        
        if checkConnection() {
            
            let escapedString = URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            
            //            let headers = ApiHandler.checkHeaders(headers: headers, authorization: authorization, OtherHeaders: [Constants.multiPartHeader, Constants.multiPartHeader])
            var newHeaders: HTTPHeaders?
            
            if authorization == nil {
                if !isAuthEqualNil { // for make CustomInterceptor work
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(authorization!)"], OtherHeaders: [Constants().multiPartHeader, Constants().multiPartHeader])
                } else {
                    newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: nil, OtherHeaders: [Constants().multiPartHeader, Constants().multiPartHeader])
                }
            } else {
                newHeaders = ApiHandler.checkHeaders(headers: headers, authorization: ["Authorization":"Bearer \(authorization!)"], OtherHeaders: [Constants().multiPartHeader, Constants().multiPartHeader])
            }
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in params {
                    multipartFormData.append((value).data(using: String.Encoding.utf8)!, withName: key)
                }
                
                if images != nil {
                    for img in images! {
                        guard let imgData = img.jpegData(compressionQuality: 0.5) else { return }
                        multipartFormData.append(imgData, withName: imageModelKey ?? "", fileName: UUID().uuidString + ".jpeg", mimeType: "image/*")
                    }
                }
                
                
            },to: URL.init(string: escapedString)!, usingThreshold: UInt64.init(),
                      method: httpMethod,
                      headers: newHeaders)
                .uploadProgress(queue: .main, closure: { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseData{ response in
                    
                    handleResponse(response: response, completed: completed)
                }
        }else{
            ApiHandler.checkInternetConnection(completed: completed)
        }
    }
    
    class private func handleResponse<T: Codable>(response: AFDataResponse<Data>, completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void) {
        
        switch response.result{
            
        case .success :
            
            do{
                guard let data = response.data else {return}
                guard let statusCode = response.response?.statusCode else {return}
                print("sttus code \(statusCode)")
                print("data is \(data)")
                do{
                    let ServerResponse = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? Any

                    DispatchQueue.main.async {
                        print("JSONSerialization response >>> \(ServerResponse ?? [:])")
                    }
                }catch{
                    print("cannot get JSONSerialization response ")
                }
                
                switch statusCode {
                case 200...400:
                    let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                    completed(1, jsonResponse, nil)
                default:
                    let errorJsonResponse = try JSONDecoder().decode(ResponseError.self, from: data)
                    completed(2, nil, errorJsonResponse)
                }
                
            }catch let DecodingError.typeMismatch(type, context) {
                print("===========Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completed(0, nil, nil)
            }catch let error {
                
                if let decodingError = error as? DecodingError{
                    print(decodingError)
                }
                
                print("--------------Response-PoG-Fail-ERROR>",error.localizedDescription)
                completed(0, nil, nil)
            }
            
        case .failure(let error) :
            guard let data = response.data else {return}
            guard let statusCode = response.response?.statusCode else {return}
            do{
                let errorJsonResponse = try JSONDecoder().decode(ResponseError.self, from: data)
                if statusCode == 405 || statusCode == 409 {
                    completed(2, nil, errorJsonResponse)
                }else{
                    completed(0, nil, nil)
                }
            }catch{
                completed(0, nil, nil)
            }
            
            print("--------------Response-PoG-Fail-ERROR>>>",error.localizedDescription)
            
        }
    }
    
    
    class private func checkHeaders(headers: [String:String]? = nil, authorization:[String:String]? = nil, OtherHeaders:[[String:String]]? = nil) -> HTTPHeaders?{
        
        var myHeader: HTTPHeaders? = nil
        var dicHeader = Constants().defaultHeader
        
        if let dic = headers {
            for item in dic {
                dicHeader[item.key] = item.value
            }
        }
        
        if let dic = authorization {
            for item in dic {
                dicHeader[item.key] = item.value
            }
        }
        
        if let dic = OtherHeaders {
            for head in dic {
                for item in head {
                    dicHeader[item.key] = item.value
                }
            }
        }
        
        myHeader = HTTPHeaders(dicHeader)
        
        return myHeader
    }
    
    class private func checkInternetConnection<T: Codable>(completed: @escaping (_ status: Int, _ response: T?, _ Error: ResponseError?) -> Void){
        
        print("--------------Post-Internet connection-ERROR")
        TopVC.dismissToast()
        TopVC.showToast("Check your internet connection", position: .top)
        completed(-1, nil, nil)
    }
}
