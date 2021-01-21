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
    
    var onChange:((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func handlePlusButton(_ sender: Any) {
        onChange?(+1)
        
    }
    @IBAction func handleMinusButton(_ sender: Any) {
        onChange?(-1)
    }
}
