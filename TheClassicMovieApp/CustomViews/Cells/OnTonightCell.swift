//
//  OnTonightCell.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class OnTonightCell: UICollectionViewCell {
   static let reuseIdentifier = "OnTonightCell"
    
   let imageView = TCMOnTonightImageView(frame: .zero)
   let titleLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .bold, minimumScaleFactor: 0.85)
   let timeLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .regular, minimumScaleFactor: 0.85)
   let separator = UIView(frame: .zero)
    
   override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   func setOnTonightCell(movie: Movie) {
      
      let startTime = movieStartTime(movie: movie)
      
      imageView.downloadImages(from: movie.profileImage!)
      titleLabel.text = movie.name
      timeLabel.text = startTime
   }
   
   
   private func configure() {
      
      let stackView = UIStackView(arrangedSubviews: [separator, imageView, titleLabel, timeLabel, separator])
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .vertical
      stackView.layer.cornerRadius = 12
      stackView.backgroundColor = .quaternaryLabel
      
      contentView.addSubview(stackView)

      NSLayoutConstraint.activate([
      
         titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
         titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
         timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),

         stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
         stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      ])

      stackView.setCustomSpacing(5, after: separator)
      stackView.setCustomSpacing(8, after: timeLabel)
  
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
   
   
   func setMoviesTonightData(movie: Movie) -> Movie {
      let moviesTonight = movie
      var startTime = movie.startDate
      
      let lowBoundRemoveDate = startTime.index(startTime.startIndex, offsetBy: 0)
      let hiBoundRemoveDate = startTime.index(startTime.endIndex, offsetBy: -11)
      let midRangeRemoveDate = lowBoundRemoveDate ..< hiBoundRemoveDate
      startTime.removeSubrange(midRangeRemoveDate)
      
      let lowBoundRemoveSeconds = startTime.index(startTime.startIndex, offsetBy: 5)
      let hiBoundRemoveSeconds = startTime.index(startTime.endIndex, offsetBy: -3)
      let midRangeRemoveSeconds = lowBoundRemoveSeconds ..< hiBoundRemoveSeconds
      startTime.removeSubrange(midRangeRemoveSeconds)
      
      let date = Date()
      let dateformatter = DateFormatter()
      dateformatter.dateFormat = "MM/dd/YYYY"
      _ = dateformatter.string(from: date)
      
      return moviesTonight
   }
}
