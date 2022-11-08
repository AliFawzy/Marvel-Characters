//
//  ResponseError.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation

struct ResponseError: Codable {
    let status: String?
    let message: String?
}
