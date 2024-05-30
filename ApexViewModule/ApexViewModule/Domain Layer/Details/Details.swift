//
//  Details.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 02/11/2023.
//

import Foundation

public struct Details {
    
    public let trackId: Int
    public let trackName: String
    public let averageUserRating: Double
    public let version: String
    public let artworkUrl: URL?
    
    public init(trackId: Int, trackName: String, averageUserRating: Double, version: String, artworkUrl100: URL? = nil) {
        self.trackId = trackId
        self.trackName = trackName
        self.averageUserRating = averageUserRating
        self.version = version
        self.artworkUrl = artworkUrl100
    }
}

extension Details: Equatable {}
