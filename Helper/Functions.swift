//
//  Functions.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation
import UIKit
import CryptoKit

public func MD5(_ string: String) -> String? {
    let hash = Insecure.MD5.hash(data: string.data(using: .utf8)!)
    return hash.map { String(format: "%02x", $0) }.joined()
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
