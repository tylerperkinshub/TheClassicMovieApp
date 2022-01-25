//
//  Movie.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import Foundation


struct Movie: Codable, Hashable {
    
    let name: String
    let startDate: String
    let length: Int?
    let releaseYear: Int?
    let profileImage: String?
    let rating: String?
    let genres: String?
    let director: String?
    let summary: String?
    let cast: String?
    let category: String?
    let sortDate: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case startDate = "StartDate"
        case length = "Length"
        case releaseYear = "ReleaseYear"
        case profileImage
        case rating = "tvRating"
        case genres = "tvGenre"
        case director = "Director"
        case summary = "Storyline"
        case cast = "Cast"
        case category = "Franchise"
        case sortDate = "SortDate"
    }
}
