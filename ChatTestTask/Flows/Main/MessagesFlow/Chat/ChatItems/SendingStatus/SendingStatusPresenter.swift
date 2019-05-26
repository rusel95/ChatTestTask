//
//  SendingStatusPresenter.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

// This is a dirty implementation that shows what's needed to add a new type of element
// @see DemoChatItemsDecorator

class SendingStatusModel: ChatItemProtocol {
    let uid: String
    static var chatItemType: ChatItemType {
        return "decoration-status"
    }
    
    var type: String { return SendingStatusModel.chatItemType }
    let status: MessageStatus
    
    init (uid: String, status: MessageStatus) {
        self.uid = uid
        self.status = status
    }
}

public class SendingStatusPresenterBuilder: ChatItemPresenterBuilderProtocol {
    
    public func canHandleChatItem(_ chatItem: ChatItemProtocol) -> Bool {
        return chatItem is SendingStatusModel ? true : false
    }
    
    public func createPresenterWithChatItem(_ chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
        assert(self.canHandleChatItem(chatItem))
        return SendingStatusPresenter(
            statusModel: chatItem as! SendingStatusModel
        )
    }
    
    public var presenterType: ChatItemPresenterProtocol.Type {
        return SendingStatusPresenter.self
    }
}

class SendingStatusPresenter: ChatItemPresenterProtocol {
    
    let statusModel: SendingStatusModel
    init (statusModel: SendingStatusModel) {
        self.statusModel = statusModel
    }
    
    static func registerCells(_ collectionView: UICollectionView) {
        collectionView.register(SendingStatusCollectionViewCell.nib,
                                forCellWithReuseIdentifier: SendingStatusCollectionViewCell.reuseIdentifier)
    }
    
    func dequeueCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SendingStatusCollectionViewCell.reuseIdentifier,
            for: indexPath
        )
        return cell
    }
    
    func configureCell(_ cell: UICollectionViewCell,
                       decorationAttributes: ChatItemDecorationAttributesProtocol?) {
        guard let statusCell = cell as? SendingStatusCollectionViewCell else {
            assert(false, "expecting status cell")
            return
        }
        
        let attrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0),
            NSAttributedString.Key.foregroundColor: self.statusModel.status == .failed ? UIColor.red : UIColor.black
        ]
        statusCell.text = NSAttributedString(
            string: self.statusText(),
            attributes: attrs)
    }
    
    func statusText() -> String {
        switch self.statusModel.status {
        case .failed:
            return NSLocalizedString("Sending failed", comment: "")
        case .sending:
            return NSLocalizedString("Sending...", comment: "")
        default:
            return ""
        }
    }
    
    var canCalculateHeightInBackground: Bool {
        return true
    }
    
    func heightForCell(maximumWidth width: CGFloat,
                       decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat {
        return 19
    }
}
