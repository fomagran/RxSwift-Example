//
//  OrderViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/21.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = """
            SELECTED MENU 1
            SELECTED MENU 2
            SELECTED MENU 3
            SELECTED MENU 4
            SELECTED MENU 5
            SELECTED MENU 6
            SELECTED MENU 7
            SELECTED MENU 8
            SELECTED MENU 9
            """
    }
    
    func updateTextViewHeight() {
          let text = textView.text ?? ""
          let width = textView.bounds.width
          let font = textView.font ?? UIFont.systemFont(ofSize: 20)

          let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
          let boundingBox = text.boundingRect(with: constraintRect,
                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                              attributes: [NSAttributedString.Key.font: font],
                                              context: nil)
          let height = boundingBox.height

        textViewHeight.constant = height + 40
      }

}
