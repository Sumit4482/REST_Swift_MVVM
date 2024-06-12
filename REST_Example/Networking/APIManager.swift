//
//  APIManager.swift
//  REST_Example
//
//  Created by E5000855 on 11/06/24.
//

import Foundation
import UIKit
class APIManager {
    
    static let shared = APIManager()
    let baseURL = URL(string: "https://example.com/api/products")!
    enum APIError: Error {
        case invalidURL
        case requestFailed
        case invalidData
        case decodingError
    }
    
    func getAllProducts(completionHandler: @escaping (Result<[Product], APIError>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 300) ~= httpResponse.statusCode else {
                completionHandler(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completionHandler(.success(products))
               
            } catch {
                completionHandler(.failure(.decodingError))
            }
        }.resume()
    }
    
    func postProduct(){
        func postProduct(product: Product, completion: @escaping (Result<Product, Error>) -> Void) {
                var request = URLRequest(url: baseURL)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
            }
    }
    
}

