//
//  RxLEOAPIProvider.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxSwift
import RxNick

final public class RxLEOAPIProvider: LEOAPIProvider {
    public init(session: URLSession = .shared) {
        nick = RxNick(session)
    }
    
    public let nick: RxNick
    
    public func request(_ route: LEOBodyfulRoute) -> Single<RxNick.Response> {
        return nick.bodyfulRequest(
            route.method,
            route.assembledUrl,
            body: route.body,
            headers: route.customHeaders)
    }
    
    public func request(_ route: LEOBodylessRoute) -> Single<RxNick.Response> {
        return nick.bodylessRequest(
            route.method,
            route.assembledUrl,
            query: route.query,
            headers: route.customHeaders)
    }
}
