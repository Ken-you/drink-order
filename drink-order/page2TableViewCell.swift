//
//  page2TableViewCell.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import UIKit

// Page2TableView Cell 的元件
class page2TableViewCell: UITableViewCell {

    @IBOutlet weak var drinkName2Label: UILabel!
    
    @IBOutlet weak var describe2Label: UILabel!
    
    @IBOutlet weak var medium2Label: UILabel!
    
    @IBOutlet weak var large2Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
