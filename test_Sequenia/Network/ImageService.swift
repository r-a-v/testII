//
//  ImageService.swift
//  test_Sequenia
//
//  Created by aleksandr_rudikov on 08.09.2021.
//

import Foundation

class ImageService {
    static func fetchImageData(from urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
