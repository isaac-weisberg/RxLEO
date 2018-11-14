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
    
    public func request<Route: LEOBodyfulRoute>(_ route: Route) -> Single<Response<Route.Response>> {
        return nick
            .bodyfulRequest(
                route.method,
                route.assembledUrl,
                body: route.body,
                headers: route.customHeaders
            )
            .ensureStatusCode(in: route.expectedStatusCodes)
            .parse()
    }
    
    public func request<Route: LEOBodylessRoute>(_ route: Route) -> Single<Response<Route.Response>> {
        return nick.bodylessRequest(
                route.method,
                route.assembledUrl,
                query: route.query,
                headers: route.customHeaders
            )
            .ensureStatusCode(in: route.expectedStatusCodes)
            .parse()
    }
}
