//
//  ContactCell.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell{
    
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var numberLabelCell: UILabel!
 
    override func awakeFromNib() {
    super.awakeFromNib()

        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
   }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
 
       // Configure the view for the selected state
        
    }
}
