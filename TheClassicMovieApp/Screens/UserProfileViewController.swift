//
//  UserProfileViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    let tableView = UITableView()
    var scheduledMovies: [Scheduled] = []
    
    
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
        PersistenceManager.retrievedScheduled { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let schedule):
                if schedule.isEmpty {
                    let alert = UIAlertController(title: "Add some movies", message: "You currently have no movies scheduled", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    self.scheduledMovies = schedule
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
}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduledMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseID) as! ScheduleCell
        let scheduled = scheduledMovies[indexPath.row]
        cell.set(schedule: scheduled)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule = scheduledMovies[indexPath.row]
        let destVC = MovieDetailsViewController()
        destVC.nameLabel.text = schedule.Name
        destVC.title = schedule.Name
        
        navigationController?.pushViewController(destVC, animated: true)
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
