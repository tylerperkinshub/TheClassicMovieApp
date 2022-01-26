//
//  PersistenceManager.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 1/25/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }
    
    
    static func updateWith(scheduled: Scheduled, actionType: PersistenceActionType, completed: @escaping (TCMError?) -> Void) {
        retrieveScheduled { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(scheduled) else {
                        completed(.unableToSchedule)
                        return
                    }
                    
                    favorites.append(scheduled)
                    
                case .remove:
                    favorites.removeAll { $0.name  == scheduled.name }
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveScheduled(completed: @escaping (Result<[Scheduled], TCMError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Scheduled].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToSchedule))
        }
    }
    
    
    static func save(favorites: [Scheduled]) -> TCMError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToSchedule
        }
    }
}


//enum Keys {
//    static let scheduled = "scheduled"
//}
//
//enum PeristenceManager {
//    static private let defaults = UserDefaults.standard
//
//    static func updateWith(scheduled: Scheduled, actionType: PersistenceActionType, completed: @escaping (TCMError?) -> Void) {
//        retrieveFavorites { result in
//            switch result {
//            case .success(let scheduledMovie):
//                var retrievedScheduled = scheduledMovie
//
//                switch actionType {
//                case .add:
//                    guard !retrievedScheduled.contains(scheduled) else {
//                        completed(.alreadyScheduled)
//                        return
//                    }
//                    retrievedScheduled.append(scheduled)
//
//                case .remove:
//                    retrievedScheduled.removeAll { $0.name == scheduled.name }
//                }
//                completed(save(scheduled: retrievedScheduled))
//
//            case .failure(let error):
//                completed(error)
//            }
//        }
//    }
//
//
//    static func retrieveFavorites(completed: @escaping (Result<[Scheduled], TCMError>) -> Void) {
//        guard let scheduledData = defaults.object(forKey: Keys.scheduled) as? Data else {
//            completed(.success([]))
//            return
//        }
//        do {
//            let decoder = JSONDecoder()
//            let scheduled = try decoder.decode([Scheduled].self, from: scheduledData)
//            completed(.success(scheduled))
//        } catch {
//            completed(.failure(.unableToSchedule))
//        }
//    }
//
//    static func save(scheduled: [Scheduled]) -> TCMError? {
//
//        do {
//            let encoder = JSONEncoder()
//            let encodedFavorites = try encoder.encode(scheduled)
//            defaults.set(encodedFavorites, forKey: Keys.scheduled)
//            return nil
//        } catch {
//            return .unableToSchedule
//        }
//    }
//}
