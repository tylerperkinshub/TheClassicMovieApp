//
//  Networking.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit


struct NetworkManager {
    
    static let shared = NetworkManager()
    private let tcmJSON = "https://tcmws.tcm.com/tcmws/NewSchedule/est"
    
    func getTCMData(completed:@escaping (Result<[Movie], TCMError>) -> Void) {
       
        guard let url = URL(string: tcmJSON) else {
            completed(.failure(.unableToCompleteRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: data)
                let duplicatesRemoved = removeDuplicateMovies(movies: movies)
                completed(.success(duplicatesRemoved))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getMoviesTonight(completed:@escaping (Result<[Movie], TCMError>) -> Void) {
        guard let url = URL(string: tcmJSON) else {
            completed(.failure(.unableToCompleteRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode([Movie].self, from: data)
                let moviesTonight = presentMoviesTonight(movies: movies)
                // print(moviesTonight.count)
                completed(.success(moviesTonight))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func removeDuplicateMovies(movies: [Movie]) -> [Movie] {
        var uniqueMovies: Set<String> = []
        var duplicatesRemoved: [Movie] = []

        
        
        for movie in movies {
            if !uniqueMovies.contains(movie.sortDate) {
                duplicatesRemoved.append(movie)
                uniqueMovies.insert(movie.sortDate)
            }
        }

        return duplicatesRemoved
     }
    
    
    func presentMoviesTonight(movies: [Movie]) -> [Movie] {
        var uniqueMovies: Set<String> = []
        var duplicatesRemoved: [Movie] = []
        var movieTonight: [Movie] = []
        var movieTonightArray: [Movie] = []
        
        for movie in movies {
            if !uniqueMovies.contains(movie.sortDate) {
                duplicatesRemoved.append(movie)
                uniqueMovies.insert(movie.sortDate)
            }
        }
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let today = dateFormatter.string(from: date)
        
        movieTonight = duplicatesRemoved.filter { $0.startDate == "\(today) 08:00:00 pm" }
        
        guard let idx1 = duplicatesRemoved.firstIndex(where: { $0 == movieTonight.first }) else {
            return movieTonight
        }
        
        for idx in stride(from: idx1, to: idx1 + 5, by: 1) {
            //print("These are strided \(idx)")
            movieTonightArray.append(duplicatesRemoved[idx])
        }
        
        return movieTonightArray
    }
}
