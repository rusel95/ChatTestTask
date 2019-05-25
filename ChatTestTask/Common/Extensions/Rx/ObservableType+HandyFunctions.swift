//
//  ObservableType+HandyFunctions.swift
//
//  Created by Eugene.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    public func doOnNext(_ onNext: ((Self.Element) -> Swift.Void)?) -> Disposable {
        return subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
}
