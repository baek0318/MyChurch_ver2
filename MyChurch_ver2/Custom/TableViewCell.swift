//
//  TableViewCell.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/14.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
