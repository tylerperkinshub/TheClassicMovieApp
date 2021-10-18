//
//  ScheduleCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/3/21.
//

import UIKit

class ScheduleCell: UITableViewCell {

    static let reuseID = "ScheduleCell"
    
    let nameLabel = TCMLabel(textAlignment: .left, fontSize: 14, fontWeight: .bold)
    let directorLabel = TCMLabel(textAlignment: .left, fontSize: 14, fontWeight: .regular)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(schedule: Scheduled) {
        nameLabel.text = schedule.Name
        directorLabel.text = schedule.SortDate
    }
    
    private func configure() {
        addSubview(nameLabel)
        addSubview(directorLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            directorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            directorLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 24),
            directorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            directorLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
}
