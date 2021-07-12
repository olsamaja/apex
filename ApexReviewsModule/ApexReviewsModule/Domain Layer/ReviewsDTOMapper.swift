//
//  ReviewsDTOMapper.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public struct ReviewsDTOMapper {
    
    static func map(_ dto: ReviewsDTO) -> [Review] {
        dto.feed.entry.map {
            EntryDTOMapper.map($0)
        }
    }
}

struct EntryDTOMapper {
    
    static func map(_ dto: EntryDTO) -> Review {
        Review(title: dto.title.label,
               author: dto.author.name.label,
               rating: dto.rating.label,
               content: dto.content.label,
               version: dto.version.label,
               updated: dto.updated.label)
    }
}
