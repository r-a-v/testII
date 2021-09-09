//
//  FilmCell.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import UIKit

class FilmCell: UITableViewCell {
    
    var viewModel: FilmCellViewModelProtocol! {
        didSet { updetaCell() }
    }
    
    static let reuseID = "filmCell"
    
//    MARK: - UIViews
    private let localNameLabel = UILabel()
    private let filmNameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let containerView = UIView(frame: .zero)
    
//    MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContainerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    MARK: - Private methods
    private func updetaCell() {
        localNameLabel.text = viewModel.filmLocalizedName
        filmNameLabel.text = viewModel.filmName
        ratingLabel.text = viewModel.filmRating > 0 ? "\(viewModel.filmRating)" : "N/A"
        ratingLabel.textColor = UIColor.ratingTextColor(for: ratingLabel.text)
    }
}

//MARK: - Configure UI
extension FilmCell {
    private func configureContainerView() {
        addLabelsToContainerView()
        customizeContainerView()
        addSubview(containerView)
        
        localNameLabel.numberOfLines = 0
        filmNameLabel.numberOfLines = 0
        ratingLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    private func customizeContainerView() {
        containerView.backgroundColor = .systemGray4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.systemGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 7)
        containerView.layer.shadowOpacity = 0.7
    }
    
    private func addLabelsToContainerView() {
        let stackView = UIStackView(arrangedSubviews: [localNameLabel, filmNameLabel],
                                    axis: .vertical,
                                    spacing: 15)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        containerView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.65),
            ratingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            ratingLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            ratingLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
            ratingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
            
        ])
    }
}
