//
//  Persistence Manager.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/1/21.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let scheduled = "scheduled" }
    
    
    static func updateWith(scheduled: Scheduled, actionType: PersistenceActionType, completed: @escaping (TCMError?) -> Void) {
        retrievedScheduled { result in
            
            switch result {
            case .success(var scheduledMovie):
                switch actionType {
                case .add:
                    guard !scheduledMovie.contains(scheduled) else {
                        completed(.alreadyScheduled)
                        return
                    }
                    scheduledMovie.append(scheduled)
                case .remove:
                    scheduledMovie.removeAll { $0.startDate == scheduled.startDate }
                }
                print(scheduledMovie)
                completed(save(scheduled: scheduledMovie))

            case .failure(let error):
                completed(error)
            }

        }
    }
    
    
    static func retrievedScheduled(completed: @escaping (Result<[Scheduled], TCMError>) -> Void) {
        guard let scheduledData = defaults.object(forKey: Keys.scheduled) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let schedule = try decoder.decode([Scheduled].self, from: scheduledData)
            completed(.success(schedule))

        } catch {
            completed(.failure(.unableToSchedule))
        }
        
    }
    
    
    static func save(scheduled: [Scheduled]) -> TCMError? {
        do {
            let encoder = JSONEncoder()
            let encodedSchedule = try encoder.encode(scheduled)
            defaults.set(encodedSchedule, forKey: Keys.scheduled)
            return nil
        } catch {
            return .unableToSchedule
        }
    }
    
}
