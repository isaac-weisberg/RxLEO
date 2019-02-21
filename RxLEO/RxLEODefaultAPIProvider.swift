//
//  RxLEODefaultAPIProvider.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxSwift

final public class RxLEODefaultAPIProvider: RxLEOAPIProvider {
    public init(session: URLSession = .shared, authFixer: @escaping (LEOAbstractRoute) -> Single<Bool>) {
        nick = RxNick(session)
        self.authFixer = authFixer
    }
    
    public let nick: RxNick
    public let authFixer: (LEOAbstractRoute) -> Single<Bool>
    
    public func request<Target: Decodable>(_ route: LEOBodyfulRoute<Target>) -> Single<Response<Target>> {
        let fixer = authFixer
        
        let request = nick
            .bodyfulRequest(
                route.method,
                route.url,
                body: route.body,
                headers: route.headers
            )
            .do(onSuccess: { response in
                if response.res.statusCode == 401 {
                    throw RxLEOAuthError()
                }
            })
        
        return request
            .catchError { error in
                let errouneousResult = Single<FreshResponse>.error(error)
                guard error is RxLEOAuthError else {
                    return errouneousResult
                }
                
                return fixer(route)
                    .flatMap { canRetry in
                        if canRetry {
                            return request
                        }
                        return errouneousResult
                    }
                    .catchError { _ in errouneousResult }
            }
            .ensureStatusCode(in: route.statusCodes)
            .parse()
    }
    
    public func request<Target: Decodable>(_ route: LEOBodylessRoute<Target>) -> Single<Response<Target>> {
        let fixer = authFixer
        
        let request = nick
            .bodylessRequest(
                route.method,
                route.url,
                query: route.query,
                headers: route.headers
            )
            .do(onSuccess: { response in
                if response.res.statusCode == 401 {
                    throw RxLEOAuthError()
                }
            })
        
        return request
            .catchError { error in
                let errouneousResult = Single<FreshResponse>.error(error)
                guard error is RxLEOAuthError else {
                    return errouneousResult
                }
                
                return fixer(route)
                    .flatMap { canRetry in
                        if canRetry {
                            return request
                        }
                        return errouneousResult
                    }
                    .catchError { _ in errouneousResult }
            }
            .ensureStatusCode(in: route.statusCodes)
            .parse()
    }
}
