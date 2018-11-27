//
//  LoginViewModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import RxSwift

final class LoginViewModel {
    
    var requestState: Observable<RequestState> {
        return model.requestState.asObservable()
    }
    
    var login: () -> Void {
        return model.login
    }
    
    private let model: LoginModel
    
    init(model: LoginModel) {
        self.model = model
    }

}
