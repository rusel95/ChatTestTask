//
//  TextMessageModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import ChattoAdditions

public protocol TestMessageModelProtocol: MessageModelProtocol {
    var status: MessageStatus { get set }
}

public class TestTextMessageModel: TextMessageModel<MessageModel>, TestMessageModelProtocol {
    
    public override init(messageModel: MessageModel, text: String) {
        super.init(messageModel: messageModel, text: text)
    }
    
    public var status: MessageStatus {
        get {
            return self._messageModel.status
        }
        set {
            self._messageModel.status = newValue
        }
    }
}
