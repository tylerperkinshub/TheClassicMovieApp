//
//  Movie.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import Foundation


struct Movie: Codable, Hashable {
    
    let Name: String
    let StartDate: String
    let Length: Int?
    let ReleaseYear: Int?
    let profileImage: String?
    let tvRating: String?
    let tvGenres: String?
    let Director: String?
    let Storyline: String?
    let Cast: String?
    let Franchise: String?
}
