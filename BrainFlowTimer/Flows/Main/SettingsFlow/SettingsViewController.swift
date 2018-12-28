//
//  SettingsViewController.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var durationsContainer: UIView!
    
    var viewModel: SettingsViewModel!
    
    private lazy var durationsView: DurationsView = {
        let view = DurationsView.loadFromNib()
        view.viewModel = viewModel.durationsViewModel
        return view
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDurationsView()
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        
    }
    
    private func configureDurationsView() {
        durationsContainer.addSubview(durationsView)
        durationsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
