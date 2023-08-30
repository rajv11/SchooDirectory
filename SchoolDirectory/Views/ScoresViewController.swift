//
//  ScoresViewController.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import UIKit

class ScoresViewController: UIViewController {
    var selectedSchool: SchoolModel? // The selected school data passed from the first screen
    var satScores: ScoreModel? // The SAT scores data fetched for the selected school
    
    // MARK: - UI Components
    private let readingScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mathScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let writingScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let extracurricularLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        // Add the UI components to the view
        view.addSubview(readingScoreLabel)
        view.addSubview(mathScoreLabel)
        view.addSubview(writingScoreLabel)
        view.addSubview(overviewLabel)
        view.addSubview(extracurricularLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            readingScoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            readingScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            readingScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mathScoreLabel.topAnchor.constraint(equalTo: readingScoreLabel.bottomAnchor, constant: 20),
            mathScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mathScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            writingScoreLabel.topAnchor.constraint(equalTo: mathScoreLabel.bottomAnchor, constant: 20),
            writingScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            writingScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            overviewLabel.topAnchor.constraint(equalTo: writingScoreLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            extracurricularLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            extracurricularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            extracurricularLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Data Population
    private func populateData() {
        guard let school = selectedSchool else {
            return
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0 // Allow multiple lines
        titleLabel.textAlignment = .center
        titleLabel.text = school.schoolName ?? "N/A"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Assign the label to the navigation item's titleView
        navigationItem.titleView = titleLabel
        
        let satReadingScore = satScores?.readingScore ?? "N/A"
        let satMathScore = satScores?.mathScore ?? "N/A"
        let satWritingScore = satScores?.writingScore ?? "N/A"
        let overView = school.overViewParagraph ?? "No Overview Available"
        let extracurricular = school.extracurricularActivities ?? "No Extracurricular Activities Available"
        
        readingScoreLabel.text = "Reading Score: \(satReadingScore)"
        mathScoreLabel.text = "Math Score: \(satMathScore)"
        writingScoreLabel.text = "Writing Score: \(satWritingScore)"
        
        overviewLabel.text = "Overview: \(overView)"
        extracurricularLabel.text = "Extracurricular: : \(extracurricular)"
    }
}
