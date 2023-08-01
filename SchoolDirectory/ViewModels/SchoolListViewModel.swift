//
//  SchoolListViewModel.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import Foundation

class SchoolListViewModel {
    private let schoolService: SchoolService
    private var satScores: [ScoreModel]?
    
    // Data source for the table view
    private var schools: [SchoolModel] = []
    
    init(schoolService: SchoolService = SchoolService.shared) {
        self.schoolService = schoolService
    }
    
    // Completion handler to update the view after data is fetched
    var onDataUpdate: (() -> Void)?
    
    // Function to fetch schools from the API using the SchoolService
    func fetchSchools(completion: @escaping (Result<[SchoolModel], Error>) -> Void) {
        schoolService.fetchSchools { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools
                // Notify the view that data is updated
                self?.onDataUpdate?()
                completion(.success(schools))
            case .failure(let error):
                // Handle the error, e.g., show an error message
                print("Error fetching schools: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // Function to fetch SAT scores for the selected school
    func fetchSATScores(completion: @escaping (Result<[ScoreModel], Error>) -> Void) {
        schoolService.fetchSATScores { [weak self] result in
            switch result {
            case .success(let scores):
                self?.satScores = scores
                self?.onDataUpdate?()
                completion(.success(scores))
            case .failure(let error):
                // Handle the error, e.g., show an error message
                print("Error fetching SAT scores: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // Function to get the number of schools for the table view
    func numberOfSchools() -> Int {
        return schools.count
    }
    
    // Function to get a specific school at an index
    func school(at index: Int) -> SchoolModel {
        return schools[index]
    }
    
    // Function to get a specific score of an school with dnb passed
    func findSchool(forDnb: String) -> ScoreModel? {
        if let scores = satScores, let result = scores.first(where: { $0.dbn == forDnb }) {
            return result
        }
        return nil
    }
}
