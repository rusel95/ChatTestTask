//
//  BaseMessageHandler.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions
import RxCocoa

final class BaseMessageHandler {
    
    let userTappedOnPhoto = BehaviorRelay<UIImage?>(value: nil)
    
    private let messageSender: TestChatMessageSender
    private let messagesSelector: MessagesSelectorProtocol
    
    init(messageSender: TestChatMessageSender, messagesSelector: MessagesSelectorProtocol) {
        self.messageSender = messageSender
        self.messagesSelector = messagesSelector
    }
    func userDidTapOnFailIcon(viewModel: TestMessageViewModelProtocol) {
        print("userDidTapOnFailIcon")
        self.messageSender.sendMessage(viewModel.messageModel)
    }
    
    func userDidTapOnAvatar(viewModel: TestMessageViewModelProtocol) {
        print("userDidTapOnAvatar")
    }
    
    func userDidTapOnBubble(viewModel: TestMessageViewModelProtocol) {
        if let viewModel = viewModel as? TestPhotoMessageViewModel,
           let model = viewModel.messageModel as? TestPhotoMessageModel {
            print(model.image)
            userTappedOnPhoto.accept(model.image)
        }
        print("userDidTapOnBubble")
    }
    
    func userDidBeginLongPressOnBubble(viewModel: TestMessageViewModelProtocol) {
        print("userDidBeginLongPressOnBubble")
    }
    
    func userDidEndLongPressOnBubble(viewModel: TestMessageViewModelProtocol) {
        print("userDidEndLongPressOnBubble")
    }
    
    func userDidSelectMessage(viewModel: TestMessageViewModelProtocol) {
        print("userDidSelectMessage")
        self.messagesSelector.selectMessage(viewModel.messageModel)
    }
    
    func userDidDeselectMessage(viewModel: TestMessageViewModelProtocol) {
        print("userDidDeselectMessage")
        self.messagesSelector.deselectMessage(viewModel.messageModel)
    }
}
