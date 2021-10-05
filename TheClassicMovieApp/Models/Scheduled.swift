//
//  Scheduled.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/1/21.
//

import Foundation

struct Scheduled: Codable, Hashable {
    
    let Name: String
    let StartDate: String
    let Length: Int?
    let ReleaseYear: Int?
    let tvRating: String?
}
