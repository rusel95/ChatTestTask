//
//  MessagesViewModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import RxSwift

final class MessagesViewModel: HasDisposeBag {
    
    private let model: MessagesModel
    
    init(model: MessagesModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
