//
//  ScheduleCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/3/21.
//

import UIKit

class ScheduleCell: UITableViewCell {

    static let reuseID = "ScheduleCell"

    let nameLabel = TCMLabel(textAlignment: .left, fontSize: 14, fontWeight: .bold, minimumScaleFactor: 0.85)
    let yearLabel = TCMLabel(textAlignment: .left, fontSize: 14, fontWeight: .light, minimumScaleFactor: 0.85)
    let startTimeLabel = TCMLabel(textAlignment: .left, fontSize: 14, fontWeight: .regular, minimumScaleFactor: 0.85)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(schedule: Scheduled) {
        nameLabel.text = schedule.name
        yearLabel.text = schedule.releaseYear
        startTimeLabel.text = String(schedule.startDate.suffix(10))
        
        

    }
    
    private func configure() {
        addSubview(startTimeLabel)
        addSubview(nameLabel)
        addSubview(yearLabel)
        
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            startTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            startTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            yearLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
            yearLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
