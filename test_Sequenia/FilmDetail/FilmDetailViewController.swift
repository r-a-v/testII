//
//  FilmDetailViewController.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import UIKit

class FilmDetailViewController: UIViewController, UITextViewDelegate {
    
    var viewModel: FilmDetailViewModelProtocol! {
        didSet { updateViews() }
    }
    
//    MARK: - UIViews
    private let filmImageView = UIImageView()
    private let filmNameLabel = UILabel()
    private let filmYearLabel = UILabel()
    private let ratingWordLabel = UILabel()
    private let filmRatingLabel = UILabel()
    private let descriptionText = UITextView()
    
//    MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        overrideUserInterfaceStyle = .light

        configureDescriptionText()
        setupConstraints()
    }
    
//    MARK: - UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        false
    }
    
//    MARK: - Private methods
    private func updateViews() {
        title = viewModel.navigationTitle
        filmNameLabel.text = viewModel.filmName
        filmNameLabel.numberOfLines = 0
        filmYearLabel.text = viewModel.yearLabel
        filmRatingLabel.text = viewModel.setRating()
        ratingWordLabel.text = "Рейтинг: "
        filmRatingLabel.textColor = UIColor.ratingTextColor(for: filmRatingLabel.text)
        descriptionText.text = viewModel.descriptionText
        
        updateFilmImageView()
    }
}

//MARK: - Configure Views
extension FilmDetailViewController {
    
    private func updateFilmImageView() {
        viewModel.getImageData { data in
            if let data = data {
                self.filmImageView.image = UIImage(data: data)
            } else {
                self.filmImageView.image = UIImage(named: "noImage")
            }
        }
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.layer.cornerRadius = 15
        filmImageView.clipsToBounds = true
    }
    
    private func configureDescriptionText() {
        descriptionText.delegate = self
        descriptionText.showsVerticalScrollIndicator = false
        descriptionText.backgroundColor = .clear
        descriptionText.font = UIFont(name: "avenir", size: 20)
    }
    
    private func setupConstraints() {
        let ratingStackView = UIStackView(
            arrangedSubviews: [ratingWordLabel, filmRatingLabel],
            axis: .horizontal,
            spacing: -1
        )
        
        let titleStackView = UIStackView(
            arrangedSubviews: [filmNameLabel, filmYearLabel, ratingStackView],
            axis: .vertical,
            spacing: 10
        )
        
        [filmImageView, descriptionText,
         ratingStackView, titleStackView].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(titleStackView)
        view.addSubview(filmImageView)
        view.addSubview(descriptionText)
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            filmImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filmImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            filmImageView.heightAnchor.constraint(equalTo: filmImageView.widthAnchor, multiplier: 1.5)
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleStackView.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleStackView.bottomAnchor.constraint(equalTo: filmRatingLabel.bottomAnchor)
        ])
                
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

    }
}
