//
// Created by AndrewPetrov on 4/18/18.
// Copyright (c) 2018 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    func withPrevious(startWith first: Element) -> Observable<(Element, Element)> {
        return scan((first, first)) { ($0.1, $1) }
    }
    
}
