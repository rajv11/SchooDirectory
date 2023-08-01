//
//  SchoolListTableVC.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import UIKit

class SchoolListTableVC: UITableViewController {
    
    private var loadingSpinner: UIActivityIndicatorView!
    private let viewModel = SchoolListViewModel() // Using only one view model as calls are made only in this VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingSpinner()
        // Set the onDataUpdate closure to update the table view when data is fetched
        viewModel.onDataUpdate = { [weak self] in
            
            DispatchQueue.main.async {
                self?.loadingSpinner.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
        fetchSchools()
        fetchScores()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: - API calls
    func fetchSchools() {
        // Show the loading spinner before making the API call
        loadingSpinner.startAnimating()
        viewModel.fetchSchools { [weak self] result in
            switch result {
            case .success:
                // Data fetched successfully, no need to show alert
                break
            case .failure(let error):
                // Display an alert for the error
                self?.loadingSpinner.stopAnimating()
                self?.showErrorAlert(with: error)
            }
        }
        
        
    }
    
    func fetchScores() {
        // Show the loading spinner before making the API call
        loadingSpinner.startAnimating()
        viewModel.fetchSATScores { [weak self] result in
            switch result {
            case .success:
                // Data fetched successfully, no need to show alert
                break
            case .failure(let error):
                // Display an alert for the error
                self?.loadingSpinner.stopAnimating()
                self?.showErrorAlert(with: error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SchoolListTableVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! SchoolTableViewCell
        
        // Configure the cell...
        
        let item = viewModel.school(at: indexPath.row)
        
        cell.schoolName.text = item.schoolName
        cell.cityLbl.text = item.city
        cell.emailLbl.text = item.schoolEmail
        cell.zipLbl.text = item.zip
        cell.phoneNumberLbl.text = item.phoneNumber
        cell.websiteLbl.text = item.website
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SchoolListTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfSchools()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected school from your data source (e.g., schoolsArray)
        let selectedSchool = viewModel.school(at: indexPath.row)
        
        // Instantiate the SchoolDetailsViewController
        let schoolDetailsVC = ScoresViewController()
        
        // Pass the selected school data and SAT scores data to the SchoolDetailsViewController
        schoolDetailsVC.selectedSchool = selectedSchool
        
        guard let selectedSchoolDbn = selectedSchool.dbn else {
            return
        }
        schoolDetailsVC.satScores = viewModel.findSchool(forDnb: selectedSchoolDbn)
        // Push the SchoolDetailsViewController onto the navigation stack
        navigationController?.pushViewController(schoolDetailsVC, animated: true)
    }
}

extension SchoolListTableVC {
    
    private func showErrorAlert(with error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupLoadingSpinner() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner.color = .gray
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingSpinner)
        
        // Center the spinner in the view
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
