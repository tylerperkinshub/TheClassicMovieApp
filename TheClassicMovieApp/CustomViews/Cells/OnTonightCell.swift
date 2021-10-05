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
   let titleLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .bold)
   let timeLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .regular)
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
      titleLabel.text = movie.Name
      timeLabel.text = startTime
   }
   
   private func configure() {
      
      let stackView = UIStackView(arrangedSubviews: [separator, imageView, titleLabel, timeLabel])
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .vertical
      //separator.backgroundColor = .quaternaryLabel
      stackView.layer.cornerRadius = 12
      stackView.backgroundColor = .quaternaryLabel
      
      contentView.addSubview(stackView)

      NSLayoutConstraint.activate([
         separator.heightAnchor.constraint(equalToConstant: 2),
         
         stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
         stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      ])
      stackView.setCustomSpacing(5, after: separator)
      //stackView.setCustomSpacing(0, after: image)
      
      
      
   }
   
   func movieStartTime(movie: Movie) -> String {
       var startTime = movie.StartDate
       
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
      var moviesTonight = movie
      var startTime = movie.StartDate
      
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
      let today = dateformatter.string(from: date)
      
      
      
      
      return moviesTonight
   }
   
    
}
