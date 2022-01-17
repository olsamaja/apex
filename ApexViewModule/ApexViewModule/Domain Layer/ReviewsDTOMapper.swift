//
//  ReviewsDTOMapper.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import ApexCore

public struct ReviewsDTOMapper {
    
    static func map(_ dto: ReviewsDTO) -> [Review] {
        dto.feed.entry.map {
            EntryDTOMapper.map($0)
        }
    }
}

struct EntryDTOMapper {
    
    static func map(_ dto: UserEntryDTO) -> Review {
        Review(title: dto.title,
               author: dto.author,
               rating: dto.rating,
               content: dto.content,
               version: dto.version,
               updated: dto.updated)
    }
}
