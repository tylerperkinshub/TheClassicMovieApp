//
//  ScheduleDayHeaderCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 10/5/21.
//

import UIKit

class ScheduleDayHeaderCell: UITableViewHeaderFooterView {

    static let resueID = "ScheduleDayHeaderCell"
    
    let dateLabel = TCMLabel(textAlignment: .left, fontSize: 26, fontWeight: .bold)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
