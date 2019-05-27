//
//  ChatViewModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import RxSwift
import RxOptional
import ChattoAdditions
import AXPhotoViewer

final class ChatViewModel: HasDisposeBag {
    
    lazy var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: messageSender,
                                  messagesSelector: messagesSelector)
    }()
    
    var photoDetaildDataSource: RxSwift.Observable<AXPhotosDataSource> {
        return baseMessageHandler.userTappedOnPhoto.filterNil()
            .map {
                return AXPhotosDataSource(photos:
                    [
                        AXPhoto(attributedTitle: nil,
                             attributedDescription: nil,
                             attributedCredit: nil,
                             imageData: nil,
                             image: $0,
                             url: nil)
                    ]
                )
            }
    }
    
    var chatDisplayName: RxSwift.Observable<String> {
        return model.userChat.filterNil()
            .map { $0.fullName }
    }
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    var messageSender: TestChatMessageSender!
    
    let messagesSelector = BaseMessagesSelector()
    let dataSource: TestChatDataSource = TestChatDataSource(count: 0, pageSize: 50)
    
    let chatScreenSendButtonText = L10n.chatScreenSendButtonText
    let chatScreenInputTextPlaceholder = L10n.chatScreenInputTextPlaceholder
    
    private let model: ChatModel
    
    init(model: ChatModel) {
        self.model = model
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        self.messageSender = dataSource.messageSender
    }
}
