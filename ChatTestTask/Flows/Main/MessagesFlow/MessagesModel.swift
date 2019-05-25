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

struct Message {
    let id: Int
    let profileURL: URL?
    let fullName: String
    let receivedDate: Date
    let messageText: String
    let role: String
    let livePlace: String
}

final class MessagesModel: EventNode, HasDisposeBag {
    
    let messages = BehaviorRelay<[Message]>(value: [])
    let selectMessageAction = PublishSubject<Message>()
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.messages.accept([Message(id: 0,
                                     profileURL: URL(string: "https://picsum.photos/40/40?grayscale")!,
                                     fullName: "Edwige Arnaud",
                                     receivedDate: Date(),
                                     messageText: "There are millions of users, and there wil…",
                                     role: "Graphic Designer - 2D Artist",
                                     livePlace: "Havana")])
        }
      
        initializeBindings()
    }
    
    private func initializeBindings() {
        selectMessageAction
            .doOnNext { [weak self] message in
                self?.raise(event: MessagesNavigationEvent.presentChat(selectedMessage: message))
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    
}
