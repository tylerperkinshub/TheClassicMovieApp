//
//  UserProfileViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit
import OrderedCollections

class UserProfileViewController: UIViewController {

    var scheduledMovies: [Scheduled] = []
    var scheduledMoviesToDisplay: [[Scheduled]] = []
    var scheduledMoviesHeaderSet: [String] = []

    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retrieveScheduled { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let schedule):
                print("This is my schedule: \(schedule)")
                if schedule.isEmpty {
                    self.scheduledMoviesToDisplay = []
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                    let alert = UIAlertController(title: "Add some movies", message: "You currently have no movies scheduled", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    self.createSectionHeaderSet(movies: schedule)
                    self.scheduledMoviesToDisplay = self.sortMoviesIntoDaysByTime(movies: schedule)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func createSectionHeaderSet(movies: [Scheduled]) {
        for movie in movies {
            let _ = scheduledMoviesHeaderSet.append(String(movie.startDate.prefix(10)))
        }
    }
    
    
    func convertMovieToDays(movies: [Scheduled], sections: Int) -> [[Scheduled]] {
        var moviesIntoDays: [[Scheduled]] = []
        var todaysMovies: [Scheduled] = []
        var itemIdx = 0
        var dayIdx = 0

        for movie in movies {
            if movie.startDate.prefix(10) != scheduledMoviesHeaderSet[itemIdx] {
                moviesIntoDays.insert(todaysMovies, at: dayIdx)
                todaysMovies.append(movie)

                todaysMovies = []
                itemIdx += 1
                dayIdx += 1
            } else {
                todaysMovies.append(movie)
            }
        }
            return moviesIntoDays
        }
    
    
    func sortMoviesIntoDaysByTime(movies: [Scheduled]) -> [[Scheduled]] {
        
        var returnedMovies: [[Scheduled]] = []
        var todaysMovies: [Scheduled] = []
        var dateSet: [String] = []
        var itemIndex = 0
        
        // creating number of days
        for movie in movies.sorted(by: {$0.startDate.prefix(10) < $1.startDate.prefix(10) }) {
            if !dateSet.contains(String(movie.startDate.prefix(10))) {
                dateSet.append(String(movie.startDate.prefix(10)))
            }
        }
        
        scheduledMoviesHeaderSet = dateSet
        
        // adding movies to 2d array sorted by time
        for movie in movies.sorted(by: {$0.startDate.prefix(10) < $1.startDate.prefix(10) }) {
            if movie.startDate.prefix(10) == dateSet[itemIndex] {
                todaysMovies.append(movie)
            } else {
                returnedMovies.insert(todaysMovies.sorted(by: { $0.startDate.suffix(10) < $1.startDate.suffix(10) }), at: itemIndex)
                itemIndex += 1
                todaysMovies = []
                todaysMovies.append(movie)
            }
        }
        // adding in movies on last day
        if todaysMovies.count > 0 {
            returnedMovies.insert(todaysMovies.sorted(by: { $0.startDate.suffix(10) < $1.startDate.suffix(10) }), at: itemIndex)
        }
        return returnedMovies
    }
}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return scheduledMoviesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let formatedSection = scheduledMoviesHeaderSet[section]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let fromDate = dateFormatter.date(from: formatedSection)!
        dateFormatter.dateFormat = "MMM, d"
        
        return dateFormatter.string(from: fromDate)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return scheduledMoviesToDisplay[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseID) as! ScheduleCell
        let scheduled = scheduledMoviesToDisplay[indexPath.section][indexPath.row]
        cell.set(schedule: scheduled)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let scheduledItem = scheduledMoviesToDisplay[indexPath.section][indexPath.row]

        PersistenceManager.updateWith(scheduled: scheduledItem, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
        
            let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        getFavorites()
    }
}
