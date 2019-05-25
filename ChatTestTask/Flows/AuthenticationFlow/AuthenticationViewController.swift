//
//  AuthenticationViewController.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
    
final class AuthenticationViewController: UIViewController {
    
    // MARK: - Properties
    //@IBOutlet private weak var signInButton: GIDSignInButton!
    
    var viewModel: AuthenticationViewModel! {
        didSet {
//            bind(requestState: viewModel.requestStateObservable)
        }
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
