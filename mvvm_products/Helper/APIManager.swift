//
//  APIManager.swift
//  mvvm_products
//
//  Created by Gaurav Sara on 26/07/23.
//

import UIKit

enum DataError: Error {
    case invalidResponse, invalidURL, invalidData, network(Error?)
}

typealias Helper = (Result<[Product], DataError>) -> Void

// Singleton Design Pattern
final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func fetchProducts(completion: @escaping Helper) {
        guard let url = URL(string: Constant.API.productURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                
                return
            }
            
            do {
                // JSONDecoder() converts the data to model
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
}
