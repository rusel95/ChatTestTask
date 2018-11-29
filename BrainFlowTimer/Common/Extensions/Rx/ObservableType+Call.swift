//
//  ObservableType+Call.swift
//
//  Created by Eugene on 4/9/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    public func call<T: AnyObject>(_ object: T, _ selector: @escaping (T) -> (E) -> Void) -> Disposable {
        return doOnNext { [weak object] value in
            if let `object` = object {
                selector(object)(value)
            }
        }
    }

    public func call<T: AnyObject>(_ object: T, _ selector: @escaping (T) -> () -> Void) -> Disposable {
        return doOnNext { [weak object] _ in
            if let `object` = object {
                selector(object)()
            }
        }
    }
}
