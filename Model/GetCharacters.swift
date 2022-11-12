//
//  GetCharacters.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation

struct GetCharacters: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: CharactersDataClass?
}

struct CharactersDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [CharactersDataClassResult]?
}

struct CharactersDataClassResult: Codable {
    let id: Int?
    let name, resultDescription: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series, stories, events: Comics_Series_Stories_Events?
    let urls: [URLElement]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

struct Comics_Series_Stories_Events: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ItemDetails]?
    let returned: Int?
}

struct ItemDetails: Codable {
    let resourceURI: String?
    let name: String?
}

struct Thumbnail: Codable {
    let path, thumbnailExtension: String?
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct URLElement: Codable {
    let type, url: String?
}
