//
//  MessagesViewModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import RxSwift

final class MessagesViewModel: HasDisposeBag {
    
    var messagesDataSource: Observable<[Message]> {
        return model.messages.asObservable()
    }
    
    let selectMessageAction = PublishSubject<Int>()
    
    private let model: MessagesModel
    
    init(model: MessagesModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        selectMessageAction.withLatestFrom(model.messages) { ($0, $1) }
            .map { index, messages in
                messages[index]
            }
            .bind(to: model.selectMessageAction)
            .disposed(by: disposeBag)
    }
    
}
