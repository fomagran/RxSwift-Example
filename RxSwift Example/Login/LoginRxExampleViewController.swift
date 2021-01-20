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
    
    
    let viewModel = LoginViewModel()
    
    //3단계
    //초기값을 항상 지정해줘야함.
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()

    }
 
    private func bindUI() {
        
        //orEmpty를 사용하면 optional값이 아닌 String으로 받아오게 된다
        emailTextField.rx.text.orEmpty
            .subscribe(onNext: {email  in self.viewModel.setEmailText(email)})
            .disposed(by: disposeBag)
        
        viewModel.emailValid
            .bind(to: emailValid.rx.isHidden)
            .disposed(by: disposeBag)
        
        //만약 로직이 컨트롤러에 있다면 아래와 같이 사용
        emailTextField.rx.text.orEmpty
            .map(checkEmailValid)
            //값이 바뀔때 ex) true true true true false면 false로 바뀔때만 값이 방출됨
            .distinctUntilChanged()
            .bind(to: emailValid.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        passwordTextField.rx.text.orEmpty
            .subscribe(onNext: {password in self.viewModel.setPasswordText(password)})
            .disposed(by: disposeBag)
        
        viewModel.passwordValid
            .bind(to: passwordValid.rx.isHidden)
            .disposed(by: disposeBag)
        
        //방법 1.로그인버튼을 뷰모델에서 판단한다.
        viewModel.loginValid
            .bind(to:loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //방법 2.컴바인레이티스트를 사용해서 뷰모델의 이메일,패스워드 밸리드를 판단해서 한번에 UI를 바꾼다.
//        Observable.combineLatest(viewModel.emailValid, viewModel.passwordValid){$0 && $1}
//            .bind(to: loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
    }
    
    private func checkEmailValid(_ email:String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    private func checkPasswordValid(_ password:String) -> Bool {
        return password.count > 5
    }
}

