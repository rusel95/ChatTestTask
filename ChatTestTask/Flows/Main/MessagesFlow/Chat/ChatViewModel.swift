//
//  ChatViewModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import RxSwift
import ChattoAdditions

final class ChatViewModel: HasDisposeBag {
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    var messageSender: TestChatMessageSender!
    
    let messagesSelector = BaseMessagesSelector()
    let dataSource: TestChatDataSource = TestChatDataSource(count: 0, pageSize: 50)
    
    let chatScreenSendButtonText = L10n.chatScreenSendButtonText
    let chatScreenInputTextPlaceholder = L10n.chatScreenInputTextPlaceholder
    
    var navigationBarTitle = Observable.just(L10n.messagesNavitaionTitle)
    
    private let model: ChatModel
    
    init(model: ChatModel) {
        self.model = model
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        self.messageSender = dataSource.messageSender
    }
    
}
