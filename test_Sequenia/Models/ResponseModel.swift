//
//  Films.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import Foundation

struct ResponseModel: Decodable {
    let films: [Film]
}

struct Film: Decodable {
    let id: Int 
    let localizedName: String
    let name: String
    let year: Int
    let rating: Double?
    let imageUrl: String?
    let description: String?
    let genres: [String]
}

