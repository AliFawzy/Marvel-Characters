//
//  Functions.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

public func MD5(_ string: String) -> String? {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    var digest = [UInt8](repeating: 0, count: length)
    if let d = string.data(using: String.Encoding.utf8) {
        d.withUnsafeBytes({ body in
            CC_MD5(body, CC_LONG(d.count), &digest)
        })
    }
    return (0..<length).reduce("") {
        $0 + String(format: "%02x", digest[$1])
    }
}

public func getCurrentTimeStamp() -> Int64 {
    return Int64(Date().timeIntervalSince1970 * 1000)
}


class DownloadImageSyncImageLoader {
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else{
            return nil
        }
        return image
    }
    
    @available(iOS 15.0, *)
    func downloadImageWithAsync(url: URL) async throws -> UIImage? {
        do {
            let (data, respone) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: respone)
        } catch {
            throw error
        }
    }
}
