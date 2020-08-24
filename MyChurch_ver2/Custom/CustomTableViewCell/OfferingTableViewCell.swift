//
//  OfferingTableViewCell.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/16.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class OfferingTableViewCell: UITableViewCell {

    @IBOutlet weak var offeringKind: UILabel!
    
    @IBOutlet weak var offeredName: UILabel!
    
    @IBOutlet weak var tableBackgroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableBackgroundView.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
