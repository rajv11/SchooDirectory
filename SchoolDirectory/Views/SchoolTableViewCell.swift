//
//  SchoolTableViewCell.swift
//  SchoolDirectory
//
//  Created by raj on 7/31/23.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zipLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
