//
//  ChatViewController.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Chatto
import ChattoAdditions

final class ChatViewController: BaseChatViewController {
    
    // MARK: - Properties
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.viewModel.messageSender,
                                  messagesSelector: self.viewModel.messagesSelector)
    }()
    
    var viewModel: ChatViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chat"
        chatDataSource = viewModel.dataSource
        viewModel.messagesSelector.delegate = self
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        
    }
    
    override func createChatInputView() -> UIView {
        let chatInputView =  ChatInputBar.loadNib()
        chatInputView.maxCharactersCount = 500
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = viewModel.chatScreenSendButtonText
        appearance.textInputAppearance.placeholderText = viewModel.chatScreenInputTextPlaceholder
        viewModel.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView,
                                                             chatInputItems: self.createChatInputItems(),
                                                             chatInputBarAppearance: appearance)
        return chatInputView
    }
    
    private func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            self?.viewModel.dataSource.addTextMessage(text)
        }
        return item
    }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { photo, _ in
            print(photo)
        }
        return item
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: TestTextMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellDefaultStyle()
        
//        let photoMessagePresenter = PhotoMessagePresenterBuilder(
//            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
//            interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
//        )
//        photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellDefaultStyle()
        
        return [
            "text-message-type": [textMessagePresenter]
//            "photo-message-type": [photoMessagePresenter],
        ]
    }
    
//    private func addRandomIncomingMessages() {
//        let button = UIBarButtonItem(
//            title: L10n.chatScreenAddRandomIncomingMessageButtonText,
//            style: .plain,
//            target: self,
//            action: #selector(addRandomMessage)
//        )
//        self.navigationItem.rightBarButtonItem = button
//    }
    
//    @objc private func addRandomMessage() {
//        self.dataSource.addRandomIncomingMessage()
//    }
}

extension ChatViewController: MessagesSelectorDelegate {
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didSelectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
    
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didDeselectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
}
