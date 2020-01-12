//
//  SegmentedTableViewCell.swift
//  ChatApp
//
//  Created by Eray on 12.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class SegmentedTableViewCell: UITableViewCell {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
