//
//  MovieListingCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class MovieListingCell: UITableViewCell {

    static let reuseIdentifier = "MovieListingCell"
    
    let sectionLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .bold, minimumScaleFactor: 0.85)
    let timeLabel = TCMLabel(textAlignment: .left, fontSize: 24, fontWeight: .bold, minimumScaleFactor: 0.5)
    let nameYearLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .bold, minimumScaleFactor: 0.75)
    let castLabel = TCMLabel(textAlignment: .left, fontSize: 12, fontWeight: .light, minimumScaleFactor: 0.85)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovieListingCell(movie: Movie) {
        
        timeLabel.text = movieStartTime(movie: movie)
        nameYearLabel.text = "\(movie.name) (\(movie.releaseYear ?? 0))"
        castLabel.text = cleanupStars(films: movie)
        
    }
    
    private func configure() {
        addSubview(timeLabel)
        addSubview(nameYearLabel)
        addSubview(castLabel)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            timeLabel.widthAnchor.constraint(equalToConstant: 60),

            nameYearLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            nameYearLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: padding),
            nameYearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameYearLabel.heightAnchor.constraint(equalToConstant: 16),

            castLabel.topAnchor.constraint(equalTo: nameYearLabel.bottomAnchor, constant: padding),
            castLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: padding),
            castLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            castLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
        
    }
    
    
    func movieStartTime(movie: Movie) -> String {
        var startTime = movie.startDate
        
        let lowBoundRemoveDate = startTime.index(startTime.startIndex, offsetBy: 0)
        let hiBoundRemoveDate = startTime.index(startTime.endIndex, offsetBy: -11)
        let midRangeRemoveDate = lowBoundRemoveDate ..< hiBoundRemoveDate
        startTime.removeSubrange(midRangeRemoveDate)
        
        let lowBoundRemoveSeconds = startTime.index(startTime.startIndex, offsetBy: 5)
        let hiBoundRemoveSeconds = startTime.index(startTime.endIndex, offsetBy: -3)
        let midRangeRemoveSeconds = lowBoundRemoveSeconds ..< hiBoundRemoveSeconds
        startTime.removeSubrange(midRangeRemoveSeconds)

        if startTime.first == "0" {
            startTime.remove(at: startTime.startIndex)
        }
        return startTime
    }
    
    
    func cleanupStars(films: Movie) -> String {
        var cleanedUpStarsReturned = ""
        
        
        if ((films.cast?.contains(", ")) != nil) {
            cleanedUpStarsReturned = films.cast?.replacingOccurrences(of: ",", with: ", ") ?? "No cast featured"
            //print(cleanedUpStarsReturned)
        }

        return cleanedUpStarsReturned
    }
}
