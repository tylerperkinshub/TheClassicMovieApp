//
//  HomeViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class HomeViewController: UIViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getData()
        view.backgroundColor = .systemBackground
        
        
    }
    
    func getData() {
        
        NetworkManager.shared.getTCMData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies) :
                self.movies.append(contentsOf: movies)
            case .failure(let error):
                print(error)
            }
            for movie in self.movies {
                print(movie.Name)
            }
        }
    }


}
