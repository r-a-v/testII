//
//  FilmDetailViewModel.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import Foundation

protocol FilmDetailViewModelProtocol {
    var navigationTitle: String { get }
    var filmName: String { get }
    var yearLabel: String { get }
    var descriptionText: String { get }
    func setRating() -> String
    func getImageData(completion: @escaping(Data?) -> Void)
    init(with film: Film)
}

class FilmDetailViewModel: FilmDetailViewModelProtocol {
    
    var navigationTitle: String {
        film.localizedName
    }

    var filmName: String {
        film.name
    }
    
    var yearLabel: String {
        "Год: \(film.year)"
    }
    
    var descriptionText: String {
        film.description ?? "Нет описания"
    }
    
    func setRating() -> String {
        guard let rating = film.rating else { return "N/A"}
        let ratingString = String(format: "%.3f", rating)
        return "\(ratingString)"
    }
    
    func getImageData(completion: @escaping(Data?) -> Void) {
        guard let urlString = film.imageUrl else {
            completion(nil)
            return
        }
        ImageService.fetchImageData(from: urlString) { data in
            completion(data)
        }
    }
    
    private let film: Film
    
    required init(with film: Film) {
        self.film = film
    }
}
