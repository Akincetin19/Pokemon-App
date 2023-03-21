//
//  PokemonService.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import Foundation

final class PokemonService {
    
    
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Empty response", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    func fetchImageData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Empty response", code: 0, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
        
    }
}
