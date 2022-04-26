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
    
    func TwentyFourHour(movieDate: String) -> String  {
        var returnedString = movieDate
        
        let lowBound = movieDate.startIndex
        let highBound = movieDate.index(movieDate.startIndex, offsetBy: 11)
        let midRange = lowBound ..< highBound
        
        
        returnedString.removeSubrange(midRange)
        
        let lowBound1 = returnedString.index(movieDate.startIndex, offsetBy: 2)
        let highBound1 = returnedString.endIndex
        let midRange1 = lowBound1 ..< highBound1
        
        returnedString.removeSubrange(midRange1)
        let twentyFour = Int(returnedString)! + 12
        
        return String(twentyFour)
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
