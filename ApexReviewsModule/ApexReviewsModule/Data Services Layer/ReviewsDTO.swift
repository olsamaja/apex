//
//  ReviewsDTO.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public struct ReviewsDTO: Decodable {
    let feed: FeedDTO
}

struct FeedDTO: Decodable {
    let entry: [EntryDTO]
}

struct EntryDTO {
    let title: TitleDTO
    let author: AuthorDTO
    let rating: RatingDTO
    let version: VersionDTO
    let content: ContentDTO
    let updated: DateDTO
}

extension EntryDTO: Decodable {
    private enum CodingKeys : String, CodingKey {
        case title = "title"
        case author = "author"
        case rating = "im:rating"
        case version = "im:version"
        case content = "content"
        case updated = "updated"
    }
}

struct TitleDTO: Decodable {
    let label: String
}

struct RatingDTO: Decodable {
    let label: String
}

struct VersionDTO: Decodable {
    let label: String
}

struct AuthorDTO: Decodable {
    let name: NameDTO
}

struct NameDTO: Decodable {
    let label: String
}

struct ContentDTO: Decodable {
    let label: String
}

struct DateDTO: Decodable {
    let label: String
}
