//
//  ChatModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class ChatModel: EventNode, HasDisposeBag {
    
    let userChat = BehaviorSubject<UserChat?>(value: nil)
    
    init(parent: EventNode, userChat: UserChat) {
        super.init(parent: parent)
        
        self.userChat.onNext(userChat)
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
    // MARK: - private
    
}
