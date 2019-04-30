//
//  AuthenticationViewController.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import GoogleSignIn
    
final class AuthenticationViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var signInButton: GIDSignInButton!
    
    var viewModel: AuthenticationViewModel! {
        didSet {
//            bind(requestState: viewModel.requestStateObservable)
        }
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        initializeBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Private Methods
    
    private func initializeBindings() {

    }
    
}

extension AuthenticationViewController: GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        print(authentication)
    }
    
}
