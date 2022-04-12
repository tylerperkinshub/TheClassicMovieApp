//
//  Scheduled.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/1/21.
//

import Foundation

struct Scheduled: Codable, Hashable {
    
    var name: String
    var startDate: String
    var length: String
    var releaseYear: String
    //var timeToSort: String = ""

    
    func deletedMatch(string: String) -> Bool {
        return startDate.contains(string)
    }
    
}
