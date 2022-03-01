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
    var scheduledMoviesHeaderSet: OrderedSet<String> = []

    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduledMoviesToDisplay = [[Scheduled(name: "Midnight Cowboy", startDate: "02/19/2022 12:15:00 am", length: "113", releaseYear: "1969")]]
        
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
                if schedule.isEmpty {
                    let alert = UIAlertController(title: "Add some movies", message: "You currently have no movies scheduled", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    //self.scheduledMovies.append(contentsOf: schedule)
                    print(schedule)
                    self.createSectionHeaderSet(movies: schedule)
                    self.scheduledMoviesToDisplay = self.convertMovieToDays(movies: schedule, sections: self.scheduledMoviesHeaderSet.count)
                    print(self.scheduledMoviesToDisplay)
                    
                    //self.scheduledMovies = schedule
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
                //moviesIntoDays.insert(todaysMovies, at: dayIdx)
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
        
        let scheduledItem = scheduledMovies[indexPath.row]
        scheduledMovies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(scheduled: scheduledItem, actionType: .remove) { [weak self]error in
            guard let self = self else { return }
            guard let error = error else { return }
            
            let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
}
