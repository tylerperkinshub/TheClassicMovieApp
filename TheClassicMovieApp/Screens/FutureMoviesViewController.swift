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
    var filteredMovies: [[Movie]] = []
    var movieSectionHeaderSet: OrderedSet<String> = []
    var splitMoviesIntoDays: [[Movie]] = []

    var dataSource: UITableViewDiffableDataSource<String, Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        getMovies()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovies()
        configureTableView()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

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
    
    
    func getMovies() {
        
        NetworkManager.shared.getTCMData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies) :
                self.movies.append(contentsOf: movies)
                self.createSectionHeaderSet(movies: movies)
                self.splitMoviesIntoDays = self.convertMovieToDays(movies: movies, sections: self.movieSectionHeaderSet.count)
                DispatchQueue.main.async { self.tableView.reloadData() }
       
            case .failure(let error):
                print(error)
            }

        }
    }
    
    func updateData(on movies: [[Movie]]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Movie>()
        snapshot.appendSections(["\([movies].count)"])
        for movie in movies {
            
            snapshot.appendItems(movie)
        }
       DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
        
    // creating data for section header textt
    func createSectionHeaderSet(movies: [Movie]){

        for movie in movies {
          let _ = movieSectionHeaderSet.append(String(movie.startDate.prefix(10)))
        }
    }
    
    
    func convertMovieToDays(movies: [Movie], sections: Int) -> [[Movie]] {
        var moviesIntoDays: [[Movie]] = []
        var todaysMovies: [Movie] = []
        var itemIdx = 0
        var dayIdx = 0

        for movie in movies {
            if movie.startDate.prefix(10) != movieSectionHeaderSet[itemIdx] {
                moviesIntoDays.insert(todaysMovies, at: dayIdx)
                todaysMovies = []
                todaysMovies.append(movie)
                itemIdx += 1
                dayIdx += 1
            } else {
                todaysMovies.append(movie)
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
        let formatedSection = movieSectionHeaderSet[section]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let fromDate = dateFormatter.date(from: formatedSection)!
        dateFormatter.dateFormat = "MMM, d"
        
        return dateFormatter.string(from: fromDate)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splitMoviesIntoDays[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListingCell.reuseIdentifier) as! MovieListingCell
        let movie = splitMoviesIntoDays[indexPath.section][indexPath.row]
        // print(movie.Name)
        
        
        cell.setMovieListingCell(movie: movie)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = splitMoviesIntoDays[indexPath.section][indexPath.row]
       
        let destinationVC = MovieDetailsViewController()
        
        destinationVC.movieHeaderImage.downloadImages(from: movie.profileImage!)
        destinationVC.nameLabel.text = movie.name
        destinationVC.yearLabel.text = "(\(movie.releaseYear ?? 1900))"
        destinationVC.lengthLabel.text = "\(movie.length ?? 0) min"
        destinationVC.ratingLabel.text = movie.rating
        destinationVC.genreLabel.text = movie.genres
        destinationVC.directorLabel.text = "Dir. \(movie.director ?? "")"
        destinationVC.categoryLabel.text = movie.category
        destinationVC.starringLabel.text = "Stars: \(movie.cast ?? "")"
        destinationVC.descriptionBodyLabel.text = movie.summary
        destinationVC.startLabel.text = movie.startDate

        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
    
    
    private func didSwipeToAddToSchedule(_ sender: UISwipeGestureRecognizer) {
        
    }
}
