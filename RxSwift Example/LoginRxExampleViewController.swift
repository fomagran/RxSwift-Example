//
//  LoginRxExampleViewController.swift
//  RxSwift Example
//
//  Created by Fomagran on 2020/12/28.
//

import UIKit
import RxSwift
import RxCocoa

class LoginRxExampleViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailValid: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValid: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    //3단계
    //초기값을 항상 지정해줘야함.
    let emailValidSubject = BehaviorSubject<Bool>(value: false)
    let passwordValidSubject = BehaviorSubject<Bool>(value: false)
    let emailInputSubject = BehaviorSubject<String>(value: "")
    let passwordInputSubject = BehaviorSubject<String>(value: "")
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//        bindUI()
        
        bindInputUI()
        bindOutputUI()
    }
    
    private func bindInputUI() {
        emailTextField.rx.text.orEmpty
            .bind(to: emailInputSubject)
            .disposed(by: disposeBag)
        
        emailInputSubject
            .map(checkEmailValid)
            .bind(to: emailValidSubject)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: passwordInputSubject)
            .disposed(by: disposeBag)
        
        passwordInputSubject
            .map(checkPasswordValid)
            .bind(to: passwordValidSubject)
            .disposed(by: disposeBag)
        
    }
    
    private func bindOutputUI() {
        emailValidSubject.subscribe(onNext:{b in self.emailValid.isHidden = b})
            .disposed(by: disposeBag)
        passwordValidSubject.subscribe(onNext:{b in self.passwordValid.isHidden = b})
            .disposed(by: disposeBag)
        
        Observable.combineLatest(emailValidSubject, passwordValidSubject,resultSelector: { $0 && $1 }).subscribe(onNext:{b in self.loginButton.isEnabled = b})
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
     
        //2단계
        let emailInput = emailTextField.rx.text.orEmpty.asObservable()
        let emailValid = emailInput.map(checkEmailValid)
        let passwordInput = passwordTextField.rx.text.orEmpty.asObservable()
        let passwordValid = passwordInput.map(checkPasswordValid)

        emailValid.subscribe(onNext:{b in self.emailValid.isHidden = b})
            .disposed(by: disposeBag)
        passwordValid.subscribe(onNext:{b in self.passwordValid.isHidden = b})
            .disposed(by: disposeBag)

        Observable.combineLatest(emailValid, passwordValid,resultSelector: {$0 && $1 }).subscribe(onNext:{b in self.loginButton.isEnabled = b})
            .disposed(by: disposeBag)
        
        //1단계
        //emailTextField.rx.text.orEmpty
        //    .map(checkEmailValid)
        //    .subscribe{bool in self.emailValid.isHidden = bool}
        //    .disposed(by: disposeBag)
        //
        //passwordTextField.rx.text.orEmpty
        //    .map(checkPasswordValid)
        //    .subscribe{bool in self.passwordValid.isHidden = bool}
        //    .disposed(by: disposeBag)
        //
        //Observable.combineLatest( emailTextField.rx.text.orEmpty
        //                            .map(checkEmailValid),   passwordTextField.rx.text.orEmpty
        //                                .map(checkPasswordValid), resultSelector: { (t1, t2) in t1 && t2 } )
        //    .subscribe(onNext: { b in self.loginButton.isEnabled = b } )
        //    .disposed(by: disposeBag)
      
    }
    
    private func checkEmailValid(_ email:String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func checkPasswordValid(_ password:String) -> Bool {
        return password.count > 5
    }
}
