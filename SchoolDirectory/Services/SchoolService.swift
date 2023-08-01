//
//  SchoolService.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import Foundation

class SchoolService {
    static let shared = SchoolService()
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    func fetchSchools(completion: @escaping (Result<[SchoolModel], Error>) -> Void) {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        networkManager.get(url: url, responseType: [SchoolModel].self) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func fetchSATScores(completion: @escaping (Result<[ScoreModel], Error>) -> Void) {
        
        // URL to fetch SAT scores for a school
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Perform the API request to fetch SAT scores
        networkManager.get(url: url, responseType: [ScoreModel].self) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

