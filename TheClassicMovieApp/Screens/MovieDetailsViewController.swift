//
//  MovieDetailsViewController.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/23/21.
//

import UIKit

protocol MovieDetailsVCDelegate: class {
    func didRequestFollowers(for movie: String)
}


class MovieDetailsViewController: UIViewController {

    let movieHeaderImage        = TCMOnTonightImageView(frame: .zero)
    let linearFill              = TCMGradientLayer(frame: .zero)
    let nameLabel               = TCMLabel(textAlignment: .left, fontSize: 20, fontWeight: .bold)
    let yearLabel               = TCMLabel(textAlignment: .left, fontSize: 20, fontWeight: .bold)
    let lengthLabel             = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .light)
    let ratingLabel             = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .light)
    let genreLabel              = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .light)
    let directorLabel           = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .regular)
    let categoryLabel           = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .regular)
    let startingLabel           = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .regular)
    let descriptionBodyLabel    = TCMBodyLabel(textAlignment: .center)
    let addToScheduleButton     = TCMButton(backgroundColor: .systemGray2, title: "Add to Schedule")
    let startLabel = TCMLabel(textAlignment: .left, fontSize: 16, fontWeight: .regular)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        configureAddToScheduleButton()

    }
    
    func configureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        view.backgroundColor = .systemBackground

    }
    
    private func configureAddToScheduleButton() {
        addToScheduleButton.addTarget(self, action: #selector(addToScheduleButtonTapped), for: .touchUpInside)
    }
    
    
    func layoutUI() {
        view.addSubview(movieHeaderImage)
//        view.addSubview(nameLabel)
//        view.addSubview(yearLabel)
        
        let nameYearStack = UIStackView(arrangedSubviews: [nameLabel, yearLabel])
        nameYearStack.spacing = .leastNonzeroMagnitude + 5
        nameYearStack.translatesAutoresizingMaskIntoConstraints = false
        nameYearStack.axis = .horizontal
        
        view.addSubview(nameYearStack)
        
        let lengthRatingGenreStack = UIStackView(arrangedSubviews: [lengthLabel, ratingLabel])
        lengthRatingGenreStack.spacing = .leastNonzeroMagnitude + 5
        lengthRatingGenreStack.translatesAutoresizingMaskIntoConstraints = false
        lengthRatingGenreStack.axis = .horizontal
        
        view.addSubview(lengthRatingGenreStack)
        
        let directorCategoryStack = UIStackView(arrangedSubviews: [directorLabel, categoryLabel])
        directorCategoryStack.spacing = .leastNonzeroMagnitude + 5
        directorCategoryStack.translatesAutoresizingMaskIntoConstraints = false
        directorCategoryStack.axis = .horizontal
        
        view.addSubview(directorCategoryStack)
        
        let starsStack = UIStackView(arrangedSubviews: [startingLabel])
        starsStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(starsStack)

        let descriptionStack = UIStackView(arrangedSubviews: [descriptionBodyLabel])
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionStack)
        view.addSubview(addToScheduleButton)
        
        
        NSLayoutConstraint.activate([
            movieHeaderImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieHeaderImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieHeaderImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieHeaderImage.heightAnchor.constraint(equalToConstant: 240),
            
            nameYearStack.topAnchor.constraint(equalTo: movieHeaderImage.bottomAnchor, constant: 12),
            nameYearStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameYearStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameYearStack.heightAnchor.constraint(equalToConstant: 24),
            
            lengthRatingGenreStack.topAnchor.constraint(equalTo: nameYearStack.bottomAnchor, constant: 12),
            lengthRatingGenreStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            lengthRatingGenreStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            lengthRatingGenreStack.heightAnchor.constraint(equalToConstant: 20),
            
            directorCategoryStack.topAnchor.constraint(equalTo: lengthRatingGenreStack.bottomAnchor, constant: 12),
            directorCategoryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            directorCategoryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            directorCategoryStack.heightAnchor.constraint(equalToConstant: 20),
            
            starsStack.topAnchor.constraint(equalTo: directorCategoryStack.bottomAnchor, constant: 12),
            starsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            starsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            starsStack.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionStack.topAnchor.constraint(equalTo: starsStack.bottomAnchor, constant: 12),
            descriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            descriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            descriptionStack.heightAnchor.constraint(equalToConstant: 100),
            
            addToScheduleButton.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 12),
            addToScheduleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            addToScheduleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            addToScheduleButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    

    
    @objc func dismissVC() {
        dismiss(animated: true)
        print("dismissedVC")
    }
    
    @objc func addToScheduleButtonTapped() {
        print("schedule button pressed")
        
        let scheduledMovie = Scheduled(Name: nameLabel.text!, SortDate: directorLabel.text!)
        PersistenceManager.updateWith(scheduled: scheduledMovie, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
//                let alert = UIAlertController(title: "Success", message: "Movie Saved", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(alert, animated: true)
//                print(scheduledMovie)
                self.dismissVC()
                return
            }
            
            let alert = UIAlertController(title: "Issue with Persistence", message: error.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)

        }
    }
}





