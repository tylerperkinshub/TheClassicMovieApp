//
//  Networking.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    private let tcmJSON = "https://tcmws.tcm.com/tcmws/MonthSchedule"
    
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
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode([Movie].self, from: data)
                let duplicatesRemoved = removeDuplicateMovies(movie: movies)
                print(duplicatesRemoved.count)
                completed(.success(duplicatesRemoved))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func removeDuplicateMovies(movie: [Movie]) -> [Movie] {
        var uniqueMovies: Set<String> = []
        var duplicatesRemoved: [Movie] = []
        
        for movie in movie {
            if !uniqueMovies.contains(movie.StartDate) {
                duplicatesRemoved.append(movie)
                uniqueMovies.insert(movie.StartDate)
            }
        }
        return duplicatesRemoved
     }
}
