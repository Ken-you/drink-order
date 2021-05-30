//
//  OrderFormTableViewCell.swift
//  drink-order
//
//  Created by yousun on 2021/5/27.
//

import UIKit

// 總訂單的 Cell 元件
class OrderFormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var sugarLabel: UILabel!
    
    @IBOutlet weak var iceLabel: UILabel!
    
    @IBOutlet weak var addLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var remarkLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
