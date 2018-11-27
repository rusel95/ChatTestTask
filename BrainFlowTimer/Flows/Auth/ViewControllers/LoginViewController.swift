//
//  LoginViewController.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController, AlertPresentable {
    
    let alert = ApplicationAlert()
    var viewModel: LoginViewModel! {
        didSet {
            bind(requestState: viewModel.requestState)
        }
    }
    
    @IBOutlet private var loginButton: UIButton! {
        didSet {
            loginButton.setTitle(tr(key: .authLoginButtonTitle), for: .normal)
        }
    }
    
    @IBAction private func login(_ sender: AnyObject) {
        viewModel.login()
    }
    
}
