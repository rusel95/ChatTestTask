//
//  ProfileModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class ProfileModel: EventNode, HasDisposeBag {
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    private func initializeBindings() {

    }
    
    // MARK: - private
    
}
