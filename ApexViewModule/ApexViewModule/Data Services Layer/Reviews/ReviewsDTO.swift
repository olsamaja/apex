//
//  ReviewsDTO.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public struct ReviewsDTO: Decodable {
    let feed: UserFeedDTO
}

struct UserFeedDTO {
    let entry: UserEntryDTOArray
    let link: AttributesDTOArray
}

typealias UserEntryDTOArray = [UserEntryDTO]

struct LinkDTO: Decodable {
    let attributes: AttributesDTOArray
}

struct AttributesDTO {
    let rel: String
    let href: URL?
}

extension AttributesDTO: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case attributes = "attributes"
    }
    
    private enum AttributesCodingKeys : String, CodingKey {
        case rel
        case href
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let attributesContainer = try container.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)
        rel = try attributesContainer.decode(String.self, forKey: AttributesCodingKeys.rel)
        
        let hrefString = try attributesContainer.decode(String.self, forKey: AttributesCodingKeys.href)
        href = URL(string: hrefString)
    }
}

typealias AttributesDTOArray = [AttributesDTO]

extension UserFeedDTO: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case entry = "entry"
        case link = "link"
    }
    
    private enum AttibutesCodingKeys : String, CodingKey {
        case attributes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        entry = try container.decode(UserEntryDTOArray.self, forKey: CodingKeys.entry)
        link = try container.decode(AttributesDTOArray.self, forKey: CodingKeys.link)
    }
}

public struct UserEntryDTO {
    let title: String
    let author: String
    let rating: String
    let version: String
    let content: String
    let updated: Date
}

extension UserEntryDTO: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case title
        case author
        case rating = "im:rating"
        case version = "im:version"
        case content
        case updated
    }
    
    private enum AuthorCodingKeys : String, CodingKey {
        case name
    }

    private enum LabelCodingKeys : String, CodingKey {
        case label
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let titleContainer = try container.nestedContainer(keyedBy: LabelCodingKeys.self, forKey: .title)
        title = try titleContainer.decode(String.self, forKey: LabelCodingKeys.label)
        
        let authorContainer = try container.nestedContainer(keyedBy: AuthorCodingKeys.self, forKey: .author)
        let nameContainer = try authorContainer.nestedContainer(keyedBy: LabelCodingKeys.self, forKey: .name)
        author = try nameContainer.decode(String.self, forKey: LabelCodingKeys.label)

        let ratingContainer = try container.nestedContainer(keyedBy: LabelCodingKeys.self, forKey: .rating)
        rating = try ratingContainer.decode(String.self, forKey: LabelCodingKeys.label)
        
        let versionContainer = try container.nestedContainer(keyedBy: LabelCodingKeys.self, forKey: .version)
        version = try versionContainer.decode(String.self, forKey: LabelCodingKeys.label)

        let contentContainer = try container.nestedContainer(keyedBy: LabelCodingKeys.self, forKey: .content)
        content = try contentContainer.decode(String.self, forKey: LabelCodingKeys.label)

        let updatedContainer = try container.nestedContainer(keyedBy: LabelCodingKeys.self, forKey: .updated)
        let dateString = try updatedContainer.decode(String.self, forKey: LabelCodingKeys.label)
        
        let dateFormatter = ISO8601DateFormatter()
        updated = dateFormatter.date(from: dateString) ?? Date()
    }
}
