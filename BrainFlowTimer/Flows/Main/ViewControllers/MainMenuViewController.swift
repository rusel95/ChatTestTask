//
//  MainMenuViewController.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainMenuViewController: UIViewController, AlertPresentable {
    
    var viewModel: MainMenuViewModel!
    let alert = ApplicationAlert()
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.username.asObservable().bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.avatar.asObservable()
            .subscribe(onNext: { url in
                self.avatarImageView.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions

private extension MainMenuViewController {
    
    @IBAction private func logOut(_ sender: Any) {
        viewModel.logOut()
    }
    
}
