////
////  UserService.swift
////  Core
////
////  Created by Ruslan Popesku on 4/30/19.
////  Copyright © 2019 Buyper. All rights reserved.
////
//
//import Foundation
//import RxSwift
//import Alamofire
//
//public final class UserService {
//    
//    private let requestManager: RequestManager
//    
//    public init(requestManager: RequestManager) {
//        self.requestManager = requestManager
//    }
//    
//    public func obtainUnregisteredUser() -> Observable<CommonAuth> {
//        
//        return requestManager.executeRequest(
//            withPath: "/unregistered_users",
//            method: .post,
//            tokenNeeded: false,
//            deviceIdNeeded: true,
//            encoding: JSONEncoding.default,
//            responseHandler: UnregisteredUserResponseHandler()
//            )
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.authorization)
//                )
//        }
//    }
//    
//    public func authorize(authToken: String) -> Observable<CommonAuth> {
//        let handler = AuthorizationResponseHandler()
//        let params: [String: Any] = ["oauth_token": authToken]
//        return requestManager.executeRequest(
//            withPath: "/users/session",
//            parameters: params,
//            method: .post,
//            deviceIdNeeded: true,
//            encoding: JSONEncoding.default,
//            responseHandler: handler
//            )
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.authorization)
//                )
//        }
//    }
//    
//    public func deleteUserSession() -> Observable<Void> {
//        let handler = CompletionResponseHandler()
//        return requestManager.executeRequest(
//            withPath: "/users/session",
//            method: .delete,
//            encoding: JSONEncoding.default,
//            responseHandler: handler
//            )
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.authorization)
//                )
//        }
//    }
//    
//    public func checkUserAttributes(attribute: String, value: Any) -> Observable<Bool> {
//        let availableAttribute = ["username", "email"]
//        guard availableAttribute.contains(attribute) else {
//            fatalError("wrong attribute")
//        }
//        let handler = BoolResponseHandler()
//        let params: [String: Any] = ["value": value]
//        return requestManager.executeRequest(
//            withPath: "/users/\(attribute)/check",
//            parameters: params,
//            method: .get,
//            tokenNeeded: false,
//            responseHandler: handler
//            )
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.authorization)
//                )
//        }
//    }
//    
//    public func getUser(identifier: Int) -> Observable<User> {
//        let handler = UserResponseHandler()
//        return requestManager.executeRequest(
//            withPath: "/users/\(identifier)",
//            method: .get,
//            deviceIdNeeded: true,
//            responseHandler: handler
//            )
//            .flatMap { user -> Observable<User> in
//                let realm = RealmService.shared.realm
//                try? realm.write {
//                    realm.add(user, update: true)
//                }
//                return Observable.just(user)
//            }
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.profile)
//                )
//        }
//    }
//    
//    public func updateProfile(identifier: Int, username: String?, avatar: String?) -> Observable<Profile> {
//        let handler = ProfileResponseHandler()
//        var params = [String: String]()
//        if username != nil {
//            params["username"] = username
//        }
//        if avatar != nil {
//            params["avatar"] = avatar
//        }
//        return requestManager.executeRequest(
//            withPath: "/profile",
//            parameters: params,
//            method: .put,
//            encoding: JSONEncoding.default,
//            responseHandler: handler
//            )
//            .flatMap { profile -> Observable<Profile> in
//                let realm = RealmService.shared.realm
//                try? realm.write {
//                    realm.add(profile, update: true)
//                }
//                return Observable.just(profile)
//            }
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.profile)
//                )
//        }
//    }
//    
//    public func getProfile() -> Observable<Profile> {
//        let handler = ProfileResponseHandler()
//        return requestManager.executeRequest(
//            withPath: "/profile",
//            method: .get,
//            responseHandler: handler
//            )
//            .flatMap { profile -> Observable<Profile> in
//                let realm = RealmService.shared.realm
//                try? realm.write {
//                    realm.add(profile, update: true)
//                }
//                return Observable.just(profile)
//            }
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.profile)
//                )
//        }
//    }
//    
//    public func getStatistic() -> Observable<Statistic> {
//        let handler = StatisticResponseHandler()
//        return requestManager.executeRequest(
//            withPath: "/statistic",
//            method: .get,
//            deviceIdNeeded: true,
//            responseHandler: handler
//            )
//            .flatMap { statistic -> Observable<Statistic> in
//                let realm = RealmService.shared.realm
//                if let profile = realm.objects(Profile.self).first {
//                    try? realm.write {
//                        profile.statistic = statistic
//                    }
//                }
//                return Observable.just(statistic)
//            }
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.profile)
//                )
//        }
//    }
//    
//    public func getAvatars() -> Observable<[Avatar]> {
//        let handler = AvatarResponseHandler()
//        return requestManager.executeRequest(
//            withPath: "/avatars",
//            method: .get,
//            responseHandler: handler
//            )
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.profile)
//                )
//        }
//    }
//    
//    public func getCommonalities(userId: Int) -> Observable<String> {
//        var params = [String: Int]()
//        params["user_id"] = userId
//        
//        return requestManager.executeRequest(
//            withPath: "/create_mode/commonalities",
//            parameters: params,
//            method: .get,
//            responseHandler: CommonalitiesResponseHandler()
//            )
//            .catchError {
//                return Observable.error(
//                    FiveAndGoError.Network.from(error: $0, context: FiveAndGoErrorContext.profile)
//                )
//        }
//    }
//    
//}
