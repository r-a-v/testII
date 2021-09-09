//
//  NetworkService.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import Foundation

class NetworkSrvice {
    
    static let shared = NetworkSrvice()
    
    private let urlString = "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json"
    
    private init() {}
    
    func fetchFilms(completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let films = try decoder.decode(ResponseModel.self, from: data)
                completion(.success(films))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
