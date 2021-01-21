//
//  MenuTableViewCell.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var menu: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func handlePlusButton(_ sender: Any) {
        
    }
    @IBAction func handleMinusButton(_ sender: Any) {
        
    }
}
