//
//  SearchResponse.swift
//  iMusic
//
//  Created by Сергей on 15.07.2024.
//

import Foundation

struct SearchResponse: Codable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Codable  {
    let trackName: String?
    let artistName: String
    let collectionName: String?
    let artworkUrl100: String?
    var previewUrl: String?
}
