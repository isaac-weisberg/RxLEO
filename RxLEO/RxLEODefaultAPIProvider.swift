//
//  RxLEODefaultAPIProvider.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxSwift
import RxNick

final public class RxLEODefaultAPIProvider: RxLEOAPIProvider {
    public init(session: URLSession = .shared) {
        nick = RxNick(session)
    }
    
    public let nick: RxNick
    
    public func request<Target: Decodable>(_ route: LEOBodyfulRoute<Target>) -> Single<Response<Target>> {
        return nick
            .bodyfulRequest(
                route.method,
                route.assembledUrl,
                body: route.body,
                headers: route.headers
            )
            .ensureStatusCode(in: route.statusCodes)
            .parse()
    }
    
    public func request<Target: Decodable>(_ route: LEOBodylessRoute<Target>) -> Single<Response<Target>> {
        return nick.bodylessRequest(
                route.method,
                route.assembledUrl,
                query: route.query,
                headers: route.headers
            )
            .ensureStatusCode(in: route.statusCodes)
            .parse()
    }
}
