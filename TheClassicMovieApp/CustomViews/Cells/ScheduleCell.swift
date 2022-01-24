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
    let timeLabel = TCMLabel(textAlignment: .left, fontSize: 14, fontWeight: .bold, minimumScaleFactor: 0.85)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(schedule: Scheduled) {
        nameLabel.text = schedule.Name
        timeLabel.text = schedule.StartDate
    }
    
    
    private func configure() {
        addSubview(nameLabel)
        addSubview(timeLabel)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 18),
            
            nameLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)

        ])
    }
}
