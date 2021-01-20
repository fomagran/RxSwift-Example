//
//  LoginViewModel.swift
//  RxSwift Example
//
//  Created by Fomagran on 2021/01/06.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let emailValid = BehaviorSubject<Bool>(value: false)
    let passwordValid = BehaviorSubject<Bool>(value: false)
    let loginValid = BehaviorSubject<Bool>(value: false)
    
    var isEmailValid = Bool()
    var isPasswordValid = Bool()
    
    func setEmailText(_ email:String) {
        isEmailValid = checkEmailValid(email)
        emailValid.onNext(isEmailValid)
        loginValid.onNext(isEmailValid && isPasswordValid)
    }
    
    func setPasswordText(_ password:String) {
        isPasswordValid = checkPasswordValid(password)
        passwordValid.onNext(isPasswordValid)
        loginValid.onNext(isEmailValid && isPasswordValid)
    }

}


//로그인에 필요한 로직들을 뷰모델에 구현한다.
//MARK:Logic

private func checkEmailValid(_ email:String) -> Bool {
    return email.contains("@") && email.contains(".")
}

private func checkPasswordValid(_ password:String) -> Bool {
    return password.count > 5
}
