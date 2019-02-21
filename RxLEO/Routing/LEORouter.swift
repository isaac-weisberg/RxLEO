//
//  LEORouter.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/14/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation

public class LEORouter {
    public let base: URL
    public let mutator: ((URLRequest) -> URLRequest)?
    
    
    public init(against url: URL, mutator: ((URLRequest) -> URLRequest)?) {
        base = url
        self.mutator = mutator
    }
    
    public func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, response: Target.Type, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodylessRoute<Target> {
        return LEOBodylessRoute(path: path, method: method, query: query, against: base, headers: headers, statusCodes: statusCodes, mutator: mutator)
    }
    
    public func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, response: Target.Type, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodyfulRoute<Target> {
        return LEOBodyfulRoute(path: path, method: method, body: body, against: base, headers: headers, statusCodes: statusCodes, mutator: mutator)
    }
    
    public func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodylessRoute<Target> {
        return LEOBodylessRoute(path: path, method: method, query: query, against: base, headers: headers, statusCodes: statusCodes, mutator: mutator)
    }
    
    public func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodyfulRoute<Target> {
        return LEOBodyfulRoute(path: path, method: method, body: body, against: base, headers: headers, statusCodes: statusCodes, mutator: mutator)
    }
}
