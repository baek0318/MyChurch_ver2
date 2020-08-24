//
//  SermonTableViewCell.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/07.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class SermonTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    @IBOutlet var sermonText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
