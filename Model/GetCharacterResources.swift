//
//  GetCharacterResources.swift
//  Marvel
//
//  Created by Mac on 11/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation


struct characterResources: Codable {
    let status: String?
    let data: characterResourcesData?
}

struct characterResourcesData: Codable {
    let results: [characterResourcesDataResults]?
}

struct characterResourcesDataResults: Codable {
    let title: String?
    let thumbnail: Thumbnail?
}

struct tempCharacterResources {
    let name: String
    let items: [characterResourcesDataResults]
}
