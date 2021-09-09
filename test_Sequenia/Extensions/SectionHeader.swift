//
//  SectionHeader.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import UIKit

class SectionHeaderView: UIView {
    
    init(with text: String) {
        super.init(frame: .zero)
        createSectionHeader(withText: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSectionHeader(withText text: String) {
        let containerView = UIView()
        let label = UILabel()
        
        label.text = text
        label.textColor = .white
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .mainPurple
        containerView.layer.cornerRadius = 5
        
        containerView.addSubview(label)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}
