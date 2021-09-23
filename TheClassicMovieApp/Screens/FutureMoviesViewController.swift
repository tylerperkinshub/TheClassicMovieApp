//
//  FutureMoviesViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class FutureMoviesViewController: UIViewController {
    
    
    enum Section { case main }
    let tableView = UITableView()
    var movies: [Movie] = []
    
    var dataSource: UITableViewDiffableDataSource<Section, Movie>!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        getMovies()
        configureTableView()
        configureDataSource()

    }
    

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieListingCell.self, forCellReuseIdentifier: MovieListingCell.reuseIdentifier)
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: tableView, cellProvider: { tableView, indexPath, movie -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListingCell.reuseIdentifier) as! MovieListingCell
            cell.setMovieListingCell(movie: movie)
            return cell
        })
    }
    
    func getMovies() {
        
        NetworkManager.shared.getTCMData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies) :
                self.movies.append(contentsOf: movies)
                self.reloadData(on: movies)
            case .failure(let error):
                print(error)
            }

        }
    }
    
    func reloadData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource?.apply(snapshot)
    }

}

extension FutureMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListingCell.reuseIdentifier) as! MovieListingCell
        let movie = movies[indexPath.row]
        cell.setMovieListingCell(movie: movie)
        
        return cell
    }
    
    
}
