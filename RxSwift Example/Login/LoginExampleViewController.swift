//
//  LoginExampleViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2020/12/28.
//

import UIKit

class LoginExampleViewController: UIViewController {

    @IBOutlet weak var emailValid: UIView!
    @IBOutlet weak var passwordValid: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func changeTextEmail(_ sender: UITextField) {
        emailValid.isHidden = checkEmailValid(sender.text ?? "")
        LoginButton.isEnabled = emailValid.isHidden == true && passwordValid.isHidden == true
       
    }
    @IBAction func changeTextPassword(_ sender: UITextField) {
        passwordValid.isHidden = checkPasswordValid(sender.text ?? "")
        LoginButton.isEnabled = emailValid.isHidden == true && passwordValid.isHidden == true
    }
    
    private func checkEmailValid(_ email:String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func checkPasswordValid(_ password:String) -> Bool {
        return password.count > 5
    }

}
