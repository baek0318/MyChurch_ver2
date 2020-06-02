//
//  SermonListTableView.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/31.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class SermonListTableView: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    @IBOutlet var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
