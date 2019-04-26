////
////  MainContainerController.swift
////  Buyper
////
////  Created by Ruslan Popesku on 4/26/19.
////  Copyright © 2019 Buyper. All rights reserved.
////
//
//import UIKit
//
//final class MainContainerController: UITabBarController {
//    
//    // MARK: - Properties
//    
//    var viewModel: MainContainerViewModel!
//    
//    override var viewControllers: [UIViewController]? {
//        didSet {
//            initializeBindings()
//            viewModel.tabBarLoaded()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//        addShadow()
//    }
//    
//    private func initializeBindings() {
//        viewModel.userPic
//            .doOnNext { [weak self] path in
//                self?.configureTabBarItem(path: path)
//                CreatedByMePin.setProfilePhoto(from: path)
//            }.disposed(by: disposeBag)
//        
//        viewModel.configureCheckLater.distinctUntilChanged()
//            .doOnNext { [weak self] tab in
//                if let tab = tab {
//                    self?.configureCheckLaterInfoBubbleView(for: tab)
//                } else {
//                    self?.checkLaterInfoBubbleView.removeFromSuperview()
//                }
//            }.disposed(by: disposeBag)
//    }
//    
//    private func addShadow() {
//        tabBar.layer.masksToBounds = false
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
//        tabBar.layer.shadowRadius = 5
//        tabBar.layer.shadowOpacity = 0.1
//    }
//    
//    private func configureTabBarItem(path: String) {
//        guard let imageURL = URL(string: path) else { return }
//        guard let viewControllers = viewControllers else { return }
//        
//        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        
//        view.kf.setImage(
//            with: imageURL,
//            placeholder: nil, options: nil,
//            progressBlock: nil
//        ) { image, _, _, _ in
//            let resizedImage = image?.kf.resize(to: CGSize(width: 30, height: 30))
//            
//            let userProfileItem = UITabBarItem(
//                title: L10n.profileTabTitle,
//                image: resizedImage?.withRenderingMode(.alwaysOriginal),
//                selectedImage: resizedImage?.withRenderingMode(.alwaysOriginal)
//            )
//            userProfileItem.setTitleTextAttributes(
//                [NSAttributedString.Key.foregroundColor: ColorName.fiveTabBarInactiveColor.color],
//                for: .normal
//            )
//            userProfileItem.setTitleTextAttributes(
//                [NSAttributedString.Key.foregroundColor: ColorName.fiveTabBarActiveColor.color],
//                for: .selected
//            )
//            
//            (viewControllers[2] as? UINavigationController)?.viewControllers.first?.tabBarItem = userProfileItem
//        }
//    }
//    
//}
//
//extension MainContainerController: UITabBarControllerDelegate {
//    
//    func tabBarController(
//        _ tabBarController: UITabBarController,
//        shouldSelect viewController: UIViewController
//        ) -> Bool {
//        guard let viewControllers = self.viewControllers,
//            !viewControllers.isEmpty,
//            let index = viewControllers.index(of: viewController),
//            let tab = Tab(rawValue: index) else { return false }
//        viewModel.switchToTabAction.onNext(tab)
//        
//        return false
//    }
//}
