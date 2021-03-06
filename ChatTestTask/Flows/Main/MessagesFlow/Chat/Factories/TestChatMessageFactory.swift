//
//  TestChatMessageFactory.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions
import Kingfisher

class TestChatMessageFactory {
    
    private static let demoText = L10n.chatScreenRandomMessageText
   
    class func makeRandomMessage(_ uid: String) -> MessageModelProtocol {
        let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
        return self.makeRandomMessage(uid, isIncoming: isIncoming)
    }
    
    class func makeRandomMessage(_ uid: String, isIncoming: Bool) -> MessageModelProtocol {
        if arc4random_uniform(100) % 2 == 0 {
            return self.makeRandomTextMessage(uid, isIncoming: isIncoming)
        } else {
            return self.makeRandomPhotoMessage(uid, isIncoming: isIncoming)
        }
    }
    
    class func makeTextMessage(_ uid: String, text: String, isIncoming: Bool) -> TestTextMessageModel {
        let messageModel = self.makeMessageModel(uid,
                                                 isIncoming: isIncoming,
                                                 type: TextMessageModel<MessageModel>.chatItemType)
        let textMessageModel = TestTextMessageModel(messageModel: messageModel, text: text)
        return textMessageModel
    }
    
    class func makePhotoMessage(_ uid: String,
                                image: UIImage,
                                size: CGSize,
                                isIncoming: Bool) -> TestPhotoMessageModel {
        let messageModel = self.makeMessageModel(uid,
                                                 isIncoming: isIncoming,
                                                 type: PhotoMessageModel<MessageModel>.chatItemType)
        let photoMessageModel = TestPhotoMessageModel(messageModel: messageModel, imageSize: size, image: image)
        return photoMessageModel
    }
    
//    static func makeCompoundMessage(isIncoming: Bool) -> TestCompoundMessageModel {
//        let messageModel = self.makeMessageModel(UUID().uuidString,
//                                                 isIncoming: isIncoming,
//                                                 type: .compoundItemType)
//        let text = isIncoming ? "Hello, how are you" : "I'm good, thanks, how about yourself?"
//        let imageName = isIncoming ? "pic-test-1" : "pic-test-2"
//        let image = UIImage(named: imageName)!
//        return DemoCompoundMessageModel(text: text,
//                                        image: image,
//                                        messageModel: messageModel)
//    }

    private class func makeRandomTextMessage(_ uid: String, isIncoming: Bool) -> TestTextMessageModel {
        let incomingText: String = isIncoming ? "incoming" : "outgoing"
        let maxText = self.demoText
        let length: Int = 10 + Int(arc4random_uniform(300))
        let text = String(maxText[..<maxText.index(maxText.startIndex, offsetBy: length)]) +
                 "\n\n\(incomingText)\n#\(uid)"
        return self.makeTextMessage(uid, text: text, isIncoming: isIncoming)
    }
    
    private class func makeRandomPhotoMessage(_ uid: String, isIncoming: Bool) -> TestPhotoMessageModel {
        var imageSize = CGSize.zero
        switch arc4random_uniform(100) % 3 {
        case 0:
            imageSize = CGSize(width: 400, height: 300)
        case 1:
            imageSize = CGSize(width: 200, height: 400)
        default:
            imageSize = CGSize(width: 300, height: 200)
        }

        var image: UIImage
        let url: URL
        switch arc4random_uniform(100) % 3 {
        case 0:
            url = URL(string: "https://picsum.photos/400/300")!
            //image = Asset.test1.image
        case 1:
            url = URL(string: "https://picsum.photos/200/400")!
            //image = Asset.test2.image
        default:
            url = URL(string: "https://picsum.photos/300/200")!
            //image = Asset.test3.image
        }
        let data = try? Data(contentsOf: url)
        image = UIImage(data: data!)!
        return self.makePhotoMessage(uid, image: image, size: imageSize, isIncoming: isIncoming)
    }
    
    private class func makeMessageModel(_ uid: String, isIncoming: Bool, type: String) -> MessageModel {
        let senderId = isIncoming ? "1" : "2"
        let messageStatus = isIncoming || arc4random_uniform(100) % 3 == 0 ? MessageStatus.success : .failed
        return MessageModel(uid: uid,
                            senderId: senderId,
                            type: type,
                            isIncoming: isIncoming,
                            date: Date(),
                            status: messageStatus)
    }
}

extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}

extension PhotoMessageModel {
    static var chatItemType: ChatItemType {
        return "photo"
    }
}

extension ChatItemType {
    static var compoundItemType = "compound"
}

extension TestChatMessageFactory {
    
    private enum DemoMessage {
        case text(String)
        case image(String)
    }
    
    private static func messages(fromDemoMessages demoMessages: [DemoMessage]) -> [MessageModelProtocol] {
        return demoMessages.map { (demoMessage) in
            let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
            switch demoMessage {
            case .text(let text):
                return TestChatMessageFactory.makeTextMessage(NSUUID().uuidString,
                                                              text: text,
                                                              isIncoming: isIncoming)
            case .image(let name):
                let image = UIImage(named: name)!
                return TestChatMessageFactory.makePhotoMessage(NSUUID().uuidString,
                                                               image: image,
                                                               size: image.size,
                                                               isIncoming: isIncoming)
            }
        }
    }
    
//    static func makeCompoundMessages() -> [MessageModelProtocol] {
//        return [
//            self.makeCompoundMessage(isIncoming: true),
//            self.makeCompoundMessage(isIncoming: false)
//        ]
//    }
    
    private static let messagesSelectionMessages: [DemoMessage] = [
        .text("Now you have an ability to select chat messages"),
        .text("Press \"Select\" to enter selection mode"),
        .text("Press \"Cancel\" to exit selection mode"),
        .text("In selection mode all interactions with bubbles are disabled"),
        .text("A message can be selected or deselected by tapping on a message cell")
    ]
    
    static func makeMessagesSelectionMessages() -> [MessageModelProtocol] {
        return self.messages(fromDemoMessages: self.messagesSelectionMessages)
    }
}
