//
//  TCMTimeAndDateComponenets.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 4/25/22.
//

import Foundation

struct TCMTimeAndDateComponenets {
    
    
    func month(movieDate: String) -> String {
        return String(movieDate.prefix(2))
    }
    
    func day(movieDate: String) -> String {
        
        var returnedString = movieDate
        
        let lowBound = movieDate.startIndex
        let highBound = movieDate.index(movieDate.startIndex, offsetBy: 3)
        let midRange = lowBound ..< highBound
        
        returnedString.removeSubrange(midRange)
        
        let lowBound1 = returnedString.index(movieDate.startIndex, offsetBy: 2)
        let highBound1 = returnedString.endIndex
        let midRange1 = lowBound1 ..< highBound1
        
        returnedString.removeSubrange(midRange1)
        
        return returnedString
    }
    
    func year(movieDate: String) -> String {
        var returnedString = movieDate
        
        let lowBound = movieDate.startIndex
        let highBound = movieDate.index(movieDate.startIndex, offsetBy: 6)
        let midRange = lowBound ..< highBound
        
        
        returnedString.removeSubrange(midRange)
        
        let lowBound1 = returnedString.index(movieDate.startIndex, offsetBy: 4)
        let highBound1 = returnedString.endIndex
        let midRange1 = lowBound1 ..< highBound1
        
        returnedString.removeSubrange(midRange1)
        
        return returnedString
    
    }
    
    func tweleveHour(movieDate: String) -> String {
        var returnedString = movieDate
        
        let lowBound = movieDate.startIndex
        let highBound = movieDate.index(movieDate.startIndex, offsetBy: 11)
        let midRange = lowBound ..< highBound
        
        
        returnedString.removeSubrange(midRange)
        
        let lowBound1 = returnedString.index(movieDate.startIndex, offsetBy: 2)
        let highBound1 = returnedString.endIndex
        let midRange1 = lowBound1 ..< highBound1
        
        returnedString.removeSubrange(midRange1)
        
        return returnedString
    }
    
    func twentyFourHour(movieDate: String) -> String  {
        var returnedString = movieDate
        
        let lowBound = movieDate.startIndex
        let highBound = movieDate.index(movieDate.startIndex, offsetBy: 11)
        let midRange = lowBound ..< highBound

        returnedString.removeSubrange(midRange)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"

        let date = dateFormatter.date(from: returnedString)
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)

        print("Movie Date: \(date24.prefix(2))")
        
        return String(date24.prefix(2))
    }
    
    func minute(movieDate: String) -> String {
        
        var returnedString = movieDate
        
        let lowBound = movieDate.startIndex
        let highBound = movieDate.index(movieDate.startIndex, offsetBy: 14)
        let midRange = lowBound ..< highBound
        
        
        returnedString.removeSubrange(midRange)
        
        let lowBound1 = returnedString.index(movieDate.startIndex, offsetBy: 2)
        let highBound1 = returnedString.endIndex
        let midRange1 = lowBound1 ..< highBound1
        
        returnedString.removeSubrange(midRange1)
        
        return returnedString
    }
    
    func amOrPm(movieDate: String) -> String {
        return String(movieDate.suffix(2))
    }
    
    
}
