//
//  ScheduleCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/3/21.
//

import UIKit

class ScheduleCell: UITableViewCell {

//    static let reuseID = "ScheduleCell"
//    
//    let timeLabel = TCMLabel(textAlignment: .left, fontSize: 12, fontWeight: .bold)
//    let nameLabel = TCMLabel(textAlignment: .center, fontSize: 12, fontWeight: .regular)
//    let yearLabel = TCMLabel(textAlignment: .left, fontSize: 12, fontWeight: .regular)
//    let castLabel = TCMLabel(textAlignment: .left, fontSize: 12, fontWeight: .light)
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        configure()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setScheduleCell(movie: Scheduled) {
//        let startTime = movieStartTime(movie: movie)
//            
//        timeLabel.text = startTime
//        nameLabel.text = movie.Name
//        yearLabel.text = "\(movie.ReleaseYear ?? 0)"
//        
//    }
//    
//    private func configure() {
////        addSubview(timeLabel)
////        addSubview(nameLabel)
////        addSubview(yearLabel)
//        
//        var stackView = UIStackView()
//        //stackView.addSubview([timeLabel, nameLabel, yearLabel])
//
//        let padding: CGFloat = 12
//        
//        NSLayoutConstraint.activate([
//            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
//            timeLabel.heightAnchor.constraint(equalToConstant: 16),
//            timeLabel.widthAnchor.constraint(equalToConstant: 60),
//                    
//            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10),
//            nameLabel.heightAnchor.constraint(equalToConstant: 16),
//            nameLabel.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor, constant: -10),
//            
//            yearLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            yearLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
//            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            yearLabel.heightAnchor.constraint(equalToConstant: 16),
//            yearLabel.widthAnchor.constraint(equalToConstant: 60)
//            
//        ])
//        
//    }
//    
//    func movieStartTime(movie: Scheduled) -> String {
//        var startTime = movie.StartDate
//        
//        let lowBoundRemoveDate = startTime.index(startTime.startIndex, offsetBy: 0)
//        let hiBoundRemoveDate = startTime.index(startTime.endIndex, offsetBy: -11)
//        let midRangeRemoveDate = lowBoundRemoveDate ..< hiBoundRemoveDate
//        startTime.removeSubrange(midRangeRemoveDate)
//        
//        
//        let lowBoundRemoveSeconds = startTime.index(startTime.startIndex, offsetBy: 5)
//        let hiBoundRemoveSeconds = startTime.index(startTime.endIndex, offsetBy: -3)
//        let midRangeRemoveSeconds = lowBoundRemoveSeconds ..< hiBoundRemoveSeconds
//        startTime.removeSubrange(midRangeRemoveSeconds)
//        
//        
//        if startTime.first == "0" {
//            startTime.remove(at: startTime.startIndex)
//        }
//             
//               
//        return startTime
//    }
//    
//    func cleanupStars(films: Scheduled) -> String {
//        var cleanedUpStarsReturned = ""
//        
//        if !((films.cast?.contains(", "))!) {
//            cleanedUpStarsReturned = films.cast?.replacingOccurrences(of: ",", with: ", ") ?? ""
//            print(cleanedUpStarsReturned)
//        }
//        
//        return cleanedUpStarsReturned
//    }
//    
}
