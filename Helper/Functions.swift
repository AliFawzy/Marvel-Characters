//
//  Functions.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation
import CommonCrypto

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
