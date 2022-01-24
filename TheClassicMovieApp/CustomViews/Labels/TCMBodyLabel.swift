//
//  TCMBodyLabel.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/27/21.
//

import UIKit

class TCMBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    
    private func configure() {
        textColor                   = .secondaryLabel
        font                        = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.85
        lineBreakMode               = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
}
