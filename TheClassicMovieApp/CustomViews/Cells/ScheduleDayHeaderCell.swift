//
//  ScheduleDayHeaderCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/5/21.
//

import UIKit
import OrderedCollections

class ScheduleDayHeaderCell: UITableViewHeaderFooterView {

    static let resueID = "ScheduleDayHeaderCell"
    
    var dateLabel = TCMLabel(textAlignment: .left, fontSize: 26, fontWeight: .bold, minimumScaleFactor: 0.85)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderCell(date: OrderedSet<String>) -> String {
        var index = 0
        let displayDate = date[index]
        
        index += 1
        
        return displayDate
    }
    
    func configure() {
        contentView.addSubview(dateLabel)
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
