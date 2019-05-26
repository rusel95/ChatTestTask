//
//  TextMessageViewModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import ChattoAdditions

public protocol TestMessageViewModelProtocol {
    var messageModel: TestMessageModelProtocol { get }
}

public class TestTextMessageViewModel: TextMessageViewModel<TestTextMessageModel>, TestMessageViewModelProtocol {
    
    public override init(textMessage: TestTextMessageModel,
                         messageViewModel: MessageViewModelProtocol) {
        super.init(textMessage: textMessage, messageViewModel: messageViewModel)
    }
    
    public var messageModel: TestMessageModelProtocol {
        return self.textMessage
    }
}

public class TestTextMessageViewModelBuilder: ViewModelBuilderProtocol {
    public init() {}
    
    let messageViewModelBuilder = MessageViewModelDefaultBuilder()
    
    public func createViewModel(_ textMessage: TestTextMessageModel) -> TestTextMessageViewModel {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(textMessage)
        let textMessageViewModel = TestTextMessageViewModel(textMessage: textMessage,
                                                            messageViewModel: messageViewModel)
        textMessageViewModel.avatarImage.value = UIImage(named: "userAvatar")
        return textMessageViewModel
    }
    
    public func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is TestTextMessageModel
    }
}
