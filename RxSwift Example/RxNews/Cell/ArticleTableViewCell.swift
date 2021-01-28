//
//  ArticleTableViewCell.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/28.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
