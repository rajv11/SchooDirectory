//
//  NetworkManger.swift
//  SchoolDirectory
//
// This class can be used to make network calls 
//  Created by raj on 7/31/23.
//

import Foundation

class NetworkManager {
    // Singleton instance
    static let shared = NetworkManager()
    
    private init() {}
    
    // Function to perform a GET request
    func get<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
