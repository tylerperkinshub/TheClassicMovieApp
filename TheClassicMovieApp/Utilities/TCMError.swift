//
//  ErrorMessages.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import Foundation

enum TCMError: String, Error {
    case invalidUsername = "This was an invalid username. Try again."
    case unableToComplete = "Unable to complete request. Check your internet."
    case invalidResponse = "Invalid response from server. Try again."
    case invalidData = "The data recived from the server was invalid. Try again."
    case unableToCompleteRequest = "Please check your internet connection"
    case unableToSchedule = "Cannot add to your schedule"
    case alreadyScheduled = "This movie has already been Scheduled"
}
