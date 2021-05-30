//
//  page4TableViewCell.swift
//  drink-order
//
//  Created by yousun on 2021/5/26.
//

import UIKit

// Page4TableView Cell 的元件
class page4TableViewCell: UITableViewCell {
    
    @IBOutlet weak var drinkName4Label: UILabel!
    
    @IBOutlet weak var describe4Label: UILabel!
    
    @IBOutlet weak var medium4Label: UILabel!
    
    @IBOutlet weak var large4Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
