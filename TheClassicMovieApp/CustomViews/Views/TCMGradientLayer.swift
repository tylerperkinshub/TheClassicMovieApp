//
//  TCMGradientLayer.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/27/21.
//

import UIKit

class TCMGradientLayer: UIView {
    
//    func setGradientBackground() {
//        let colorTop =  UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0).cgColor
//        let colorBottom = UIColor(red: 42.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1.0).cgColor
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.linearFill.bounds
//
//        self.view.layer.insertSublayer(gradientLayer, at:1)
//    }
//
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        let colorTop =  UIColor.white.cgColor
        let colorBottom = UIColor.black.cgColor
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
    }
}
