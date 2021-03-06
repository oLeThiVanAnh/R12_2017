//
//  ContactTableViewCell.swift
//  Contact Keeper
//
//  Created by LeThiVan.Anh on 30/1/17.
//  Copyright © 2017 Friench. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
