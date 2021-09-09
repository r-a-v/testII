//
//  FilmCellViewModel.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import Foundation

protocol FilmCellViewModelProtocol {
    var filmLocalizedName: String { get }
    var filmName: String { get }
    var filmRating: Double { get }
    init(film: Film)
}

class FilmCellViewModel: FilmCellViewModelProtocol {
    var filmLocalizedName: String {
        film.localizedName
    }
    
    var filmName: String {
        film.name
    }
    
    var filmRating: Double {
        film.rating ?? 0
    }
    
    private let film: Film!
    
    required init(film: Film) {
        self.film = film
    }
}
