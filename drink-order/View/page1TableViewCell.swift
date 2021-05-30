//
//  menu1TableViewCell.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import UIKit

// Page1TableView Cell 的元件
class page1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    @IBOutlet weak var describeLabel: UILabel!
    
    @IBOutlet weak var mediumLabel: UILabel!
    
    @IBOutlet weak var largeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
