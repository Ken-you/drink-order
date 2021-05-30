//
//  page3TableViewCell.swift
//  drink-order
//
//  Created by yousun on 2021/5/26.
//

import UIKit

// Page3TableView Cell 的元件
class page3TableViewCell: UITableViewCell {

    @IBOutlet weak var drinkName3Label: UILabel!
    
    @IBOutlet weak var describe3Label: UILabel!
    
    @IBOutlet weak var medium3Label: UILabel!
    
    @IBOutlet weak var large3Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
