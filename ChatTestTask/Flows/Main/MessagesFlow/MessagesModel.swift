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
        let userChatJSON = [
            "id": 0,
            "profile_url": "https://picsum.photos/40/40?grayscale",
            "full_name": "Edwige Arnaud",
            "received_date": "Yesterday",
            "last_message_text": "There are millions of users, and there will do that",
            "role": "Graphic Designer - 2D Artist",
            "current_location_name": "Havana"] as [String : Any]

        if let userChat = UserChat(json: userChatJSON) {
            messages.accept([userChat])
        }
    }
}
