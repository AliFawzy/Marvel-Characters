//
//  GetCharacters.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import Foundation

// MARK: - GetCharacters
struct GetCharacters: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: CharactersDataClass?
}

// MARK: - DataClass
struct CharactersDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [CharactersDataClassResult]?
}

// MARK: - Result
struct CharactersDataClassResult: Codable {
    let id: Int?
    let name, resultDescription: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String?
}


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String?
}

