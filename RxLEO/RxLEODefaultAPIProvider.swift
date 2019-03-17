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
            .map { result in
                result
                    .mapError { .failure(RxLEOError.nick($0)) }
                    .map { fresh -> RxNickResult<Response<Target>, RxLEOError> in
                        let errorResult: RxNickResult<Response<LEOErrorResponse>, NickError> = fresh.json()
                        if case .success(let errorResp) = errorResult {
                            return .failure(RxLEOError.businessProblem(errorResp.target))
                        }
                        
                        return fresh.json().mapError { .failure(RxLEOError.nick($0)) }
                }
            }
    }
    
    public func request<Target: Decodable>(_ route: LEOBodylessRoute<Target>) -> Single<RxNickResult<Response<Target>, RxLEOError>> {
        return nick
            .bodylessRequest(
                route.method,
                route.url,
                query: route.query,
                headers: route.headers
            )
            .map { result in
                result
                    .mapError { .failure(RxLEOError.nick($0)) }
                    .map { fresh -> RxNickResult<Response<Target>, RxLEOError> in
                        let errorResult: RxNickResult<Response<LEOErrorResponse>, NickError> = fresh.json()
                        if case .success(let errorResp) = errorResult {
                            return .failure(RxLEOError.businessProblem(errorResp.target))
                        }
                        
                        return fresh.json().mapError { .failure(RxLEOError.nick($0)) }
                    }
            }
    }
}
