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
        
        self.chatDataSource = viewModel.dataSource
        self.viewModel.messagesSelector.delegate = self
        self.chatItemsDecorator = TestChatItemsDecorator(messagesSelector: self.viewModel.messagesSelector)
        addRandomIncomingMessagesButton()
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        viewModel.chatDisplayName
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
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
        items.append(createTextInputItem())
        items.append(createPhotoInputItem())
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
        item.photoInputHandler = { [weak self] photo, _ in
            self?.viewModel.dataSource.addPhotoMessage(photo)
        }
        return item
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: TestTextMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellDefaultStyle()
        
        let photoMessagePresenter = PhotoMessagePresenterBuilder(
            viewModelBuilder: TestPhotoMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellDefaultStyle()
        
        return [
            TestTextMessageModel.chatItemType: [textMessagePresenter],
            TestPhotoMessageModel.chatItemType: [photoMessagePresenter]
        ]
    }
}

// MARK: Random Message Button
extension ChatViewController {
    
    private func addRandomIncomingMessagesButton() {
        let button = UIBarButtonItem(
            title: L10n.chatScreenAddRandomIncomingMessageButtonText,
            style: .plain,
            target: self,
            action: #selector(addRandomMessage)
        )
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addRandomMessage() {
        viewModel.dataSource.addRandomIncomingMessage()
    }
}

extension ChatViewController: MessagesSelectorDelegate {
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didSelectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
    
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didDeselectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
}
