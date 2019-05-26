//
//  MessagesModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

typealias UserChat = Core.UserChat

final class MessagesModel: EventNode, HasDisposeBag {
    
    let messages = BehaviorRelay<[UserChat]>(value: [])
    let selectMessageAction = PublishSubject<UserChat>()
    
    override init(parent: EventNode) {
        super.init(parent: parent)
      
        initializeBindings()
        fetchMessages()
    }
    
    private func initializeBindings() {
        selectMessageAction
            .doOnNext { [weak self] message in
                self?.raise(event: MessagesNavigationEvent.presentChat(selectedMessage: message))
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    private func fetchMessages() {
        // NOTE: just a test data
//        let userChat = [UserChat.construct(from: JSONFIl)
//        messages.accept(
//            (id: 0,
//                                 profileURL: URL(string: "https://picsum.photos/40/40?grayscale")!,
//                                 fullName: "Edwige Arnaud",
//                                 receivedDate: Date(),
//                                 lastMessageText: "There are millions of users, and there wil…",
//                                 role: "Graphic Designer - 2D Artist",
//                                 livePlace: "Havana") ] )
    }
}
