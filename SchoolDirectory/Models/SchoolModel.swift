//
//  File.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import Foundation

struct SchoolModel: Codable {
    let dbn: String?
    let schoolName:String?
    let schoolEmail: String?
    let website: String?
    let city: String?
    let phoneNumber: String?
    let zip: String?
    let overViewParagraph: String?
    let extracurricularActivities: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case website
        case city
        case zip
        case schoolName = "school_name"
        case schoolEmail = "school_email"
        case phoneNumber = "phone_number"
        case overViewParagraph = "overview_paragraph"
        case extracurricularActivities = "extracurricular_activities"
    }
}
