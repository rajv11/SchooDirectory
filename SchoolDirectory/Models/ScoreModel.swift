//
//  ScoreModel.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import Foundation


//Reading score
//Math score
//Writing score
//
//OverView Paragraph
//
//Extracurricular activities
struct ScoreModel: Codable {
    let dbn: String?
    let schoolName: String?
    let readingScore: String?
    let mathScore: String?
    let writingScore: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case readingScore = "sat_critical_reading_avg_score"
        case mathScore = "sat_math_avg_score"
        case writingScore = "sat_writing_avg_score"
    }
    
}
