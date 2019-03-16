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
    public init(session: URLSession = .shared) {
        nick = RxNick(session)
    }
    
    public let nick: RxNick
    
    public func request<Target: Decodable>(_ route: LEOBodyfulRoute<Target>) -> Single<RxNickResult<Response<Target>, RxLEOError>> {
        return nick
            .bodyfulRequest(route.method,
                            route.url,
                            body: route.body,
                            headers: route.headers)
            .map { $0.map { res -> RxNickResult<Response<Target>, NickError> in res.json() } }
            .map { $0.mapError { .failure(.nick($0)) } }
    }
    
    public func request<Target: Decodable>(_ route: LEOBodylessRoute<Target>) -> Single<RxNickResult<Response<Target>, RxLEOError>> {
        return nick
            .bodylessRequest(
                route.method,
                route.url,
                query: route.query,
                headers: route.headers
            )
            .map { $0.map { res -> RxNickResult<Response<Target>, NickError> in res.json() } }
            .map { $0.mapError { .failure(.nick($0)) } }
    }
}
