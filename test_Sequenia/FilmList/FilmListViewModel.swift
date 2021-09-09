//
//  FilmListViewModel.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import Foundation

//MARK: - FilmListViewModelProtocol
protocol FilmListViewModelProtocol {
    var films: [Int: [Film]] { get }
    var numberOfSections: Int { get }
    func sectionName(section: Int) -> String
    func numberOfRows(in section: Int) -> Int
    func getFilms(completion: @escaping() -> Void)
    func filmCellViewModel(atIndexPath indexPath: IndexPath) -> FilmCellViewModelProtocol?
    func filmDetailVIewModel(atIndexPath indexPath: IndexPath) -> FilmDetailViewModelProtocol?
}

//MARK: - FilmListViewModel
class FilmListViewModel: FilmListViewModelProtocol {
    
    var films: [Int: [Film]] = [:]
    
    var numberOfSections: Int {
        films.keys.count
    }
    
    func sectionName(section: Int) -> String {
        let sectionName = getSection(at: section)
        return "\(sectionName)"
    }
    
    func numberOfRows(in section: Int) -> Int {
        let section = getSection(at: section)
        guard let rows = films[section] else { return 0 }
        return rows.count
    }
    
    func getFilms(completion: @escaping() -> Void) {
        NetworkSrvice.shared.fetchFilms { result in
            switch result {
            case .success(let result):
                self.films = self.sortFilms(films: result.films)
                completion()
            case .failure(_):
                completion()
            }
        }
    }
    
    func filmCellViewModel(atIndexPath indexPath: IndexPath) -> FilmCellViewModelProtocol? {
        let section = getSection(at: indexPath.section)
        if let films = films[section] {
            let film = films[indexPath.row]
            let filmCellViewModel = FilmCellViewModel(film: film)
            return filmCellViewModel
        }
        return nil
    }

    func filmDetailVIewModel(atIndexPath indexPath: IndexPath) -> FilmDetailViewModelProtocol? {
        let section = getSection(at: indexPath.section)
        if let films = films[section] {
            let film = films[indexPath.row]
            let filmDetailViewModel = FilmDetailViewModel(with: film)
            return filmDetailViewModel
        }
        return nil
    }
    
//    MARK: - Private methods
    private func sortFilms(films: [Film]) -> [Int: [Film]] {
        let sortedArr = films.sorted { $0.rating ?? 0 > $1.rating ?? 0}
        var sortedFilms: [Int: [Film]] = [:]
        
        sortedArr.forEach { film in
            if sortedFilms[film.year] != nil {
                sortedFilms[film.year]?.append(film)
            } else {
                sortedFilms.updateValue([film], forKey: film.year)
            }
        }
        return sortedFilms
    }
    
    private func getSection(at section: Int) -> Int {
        films.keys.sorted(by: <)[section] as Int
    }
}
