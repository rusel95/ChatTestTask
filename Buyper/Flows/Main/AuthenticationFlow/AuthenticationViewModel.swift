//
//  AuthenticationViewModel.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import RxSwift

final class AuthenticationViewModel: HasDisposeBag {
    
    // MARK: - Properties.
    
    var requestStateObservable: Observable<RequestState> {
        return model.requestStateObservable.asObservable()
    }

    private let model: AuthenticationModel
    
    // MARK: - Init.
    
    init(model: AuthenticationModel) {
        self.model = model
        
        initializeBindings()
    }
    
    // MARK: - Private Method.
    
    private func initializeBindings() {

    }
}
