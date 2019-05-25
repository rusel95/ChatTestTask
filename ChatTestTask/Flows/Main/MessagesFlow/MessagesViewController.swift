//
//  MessagesViewController.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MessagesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: MessagesViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        tableView.register(MessageTableViewCell.self,
                           forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        
        viewModel.messagesDataSource
            .bind(to: tableView.rx.items(cellIdentifier: MessageTableViewCell.reuseIdentifier,
                                         cellType: MessageTableViewCell.self)) { _, data, cell in
                cell.configure(with: data)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.map { $0.row }
            .bind(to: viewModel.selectMessageAction)
            .disposed(by: disposeBag)
    }
    
}
