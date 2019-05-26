//
//  TestMessageModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import ChattoAdditions

public class TestPhotoMessageModel: PhotoMessageModel<MessageModel>, TestMessageModelProtocol {
    public override init(messageModel: MessageModel, imageSize: CGSize, image: UIImage) {
        super.init(messageModel: messageModel, imageSize: imageSize, image: image)
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
