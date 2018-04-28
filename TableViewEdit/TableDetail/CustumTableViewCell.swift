//
//  CustumTableViewCell.swift
//  TableViewEdit
//
//  Created by KERCKWEB on 05/04/2018.
//  Copyright © 2018 KERCKWEB. All rights reserved.
//

import UIKit

class CustumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LabelA: UILabel!
    
    @IBOutlet weak var labelB: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
