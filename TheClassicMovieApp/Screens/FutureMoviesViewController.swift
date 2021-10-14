//
//  FutureMoviesViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit
import OrderedCollections

class FutureMoviesViewController: UIViewController {
    
    
    enum Section { case main }
    let tableView = UITableView()
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var isSearching = false
    var movieSectionHeaderSet: OrderedSet<String> = []
    var splitMoviesIntoDays: [[Movie]] = []

    
    
    //var dataSource: UITableViewDiffableDataSource<Section, Movie>!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        getMovies()
        configureTableView()
        //configureDataSource()

    }
    

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieListingCell.self, forCellReuseIdentifier: MovieListingCell.reuseIdentifier)
    }
    
//    func configureDataSource() {
//        dataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: tableView, cellProvider: { tableView, indexPath, movie -> UITableViewCell in
//            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListingCell.reuseIdentifier) as! MovieListingCell
//
//            cell.setMovieListingCell(movie: movie)
//            return cell
//        })
//    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find a film"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func getMovies() {
        
        NetworkManager.shared.getTCMData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies) :
                self.movies.append(contentsOf: movies)
                self.createSectionHeaderSet(movies: movies)
                self.splitMoviesIntoDays = self.convertMovieToDays(movies: movies, sections: self.movieSectionHeaderSet.count)
                //print(self.splitMoviesIntoDays)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //print(self.splitMoviesIntoDays)
                //self.reloadData(on: self.splitMoviesIntoDays)
//                for movies in self.splitMoviesIntoDays {
//
//                }
               
                
            case .failure(let error):
                print(error)
            }

        }
    }
    
//    func reloadData(on movies: [[Movie]]) {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
//        snapshot.appendSections([.main])
//        for movie in movies {
//
//            snapshot.appendItems(movie)
//        }
//
//        dataSource?.apply(snapshot)
//    }
    
    
    // creating data for section header textt
    func createSectionHeaderSet(movies: [Movie]){

        for movie in movies {
            movieSectionHeaderSet.append(String(movie.StartDate.prefix(10)))
            //print(movieSectionHeaderSet)
        }
        //print("Movie set: \(movieSectionHeaderSet.count)")
    }
    
    func convertMovieToDays(movies: [Movie], sections: Int) -> [[Movie]] {
        var moviesIntoDays: [[Movie]] = []
        var todaysMovies: [Movie] = []
        var itemIdx = 0
        var dayIdx = 0

        for movie in movies {
            if movie.StartDate.prefix(10) == movieSectionHeaderSet[itemIdx] {
                todaysMovies.append(movie)
            } else {
                moviesIntoDays.insert(todaysMovies, at: dayIdx)
                itemIdx += 1
                dayIdx += 1
                todaysMovies = []
            }
        }
        return moviesIntoDays
        }

}

extension FutureMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return splitMoviesIntoDays.count
    }
        
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(movieSectionHeaderSet[section])"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(splitMoviesIntoDays)
        return splitMoviesIntoDays[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListingCell.reuseIdentifier) as! MovieListingCell
        let movie = splitMoviesIntoDays[indexPath.section][indexPath.row]
        print(movie)
        cell.setMovieListingCell(movie: movie)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredMovies : movies
        let movie = splitMoviesIntoDays[indexPath.section][indexPath.row]
        
        
        let destinationVC = MovieDetailsViewController()
        
        destinationVC.movieHeaderImage.downloadImages(from: movie.profileImage!)
        destinationVC.nameLabel.text = movie.Name
        destinationVC.yearLabel.text = "(\(movie.ReleaseYear ?? 1900))"
        destinationVC.lengthLabel.text = "\(movie.Length ?? 0) min"
        destinationVC.ratingLabel.text = movie.tvRating
        destinationVC.genreLabel.text = movie.tvGenres
        destinationVC.directorLabel.text = "Dir. \(movie.Director ?? "")"
        destinationVC.categoryLabel.text = movie.Franchise
        destinationVC.startingLabel.text = "Stars: \(movie.Cast ?? "")"
        destinationVC.descriptionBodyLabel.text = movie.Storyline

        
        
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
    
}

extension FutureMoviesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredMovies = movies.filter { $0.Name.lowercased().contains(filter.lowercased()) }
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }


    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



