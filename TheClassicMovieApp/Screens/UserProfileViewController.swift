//
//  UserProfileViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    let tableView = UITableView()
    var schedule: [Scheduled] = []
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureViewController()
//        configureTableView()
//    }
//    
//    func configureViewController() {
//        view.backgroundColor = .systemBackground
//        title = "Schedule"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    
//    func configureTableView() {
//        view.addSubview(tableView)
//        
//        tableView.frame = view.bounds
//        tableView.rowHeight = 80
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseID)
//        
//    }
//    
//    func getSchedule() {
//        PersistenceManager.retrievedScheduled { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//                
//            case .success(let schedule):
//                if schedule.isEmpty {
//                    let alert = UIAlertController(title: "No schedule", message: "Add movies to your schedule", preferredStyle: .alert)
//                    DispatchQueue.main.async { self.present(alert, animated: true) }
//                }
//            case .failure(let error):
//                let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
//                DispatchQueue.main.async { self.present(alert, animated: true) }
//            }
//        }
//    }
//

}

//extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return schedule.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseID) as! ScheduleCell
//        let schedule = schedule[indexPath.row]
//        cell.setScheduleCell(movie: schedule)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let scheduled = schedule[indexPath.row]
//        let destVC = MovieDetailsViewController()
//        destVC.title = scheduled.Name
//        
//        navigationController?.pushViewController(destVC, animated: true)
//    }
//    
//    
//}
