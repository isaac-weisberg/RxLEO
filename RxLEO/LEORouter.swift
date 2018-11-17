//
//  LEORouter.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/14/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxNick

public class LEORouter {
    public let base: URL
    
    public init(against url: URL) {
        base = url
    }
    
    public func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, response: Target.Type, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodylessRoute<Target> {
        return LEOBodylessRoute(path: path, method: method, query: query, against: base, headers: headers, statusCodes: statusCodes)
    }
    
    public func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, response: Target.Type, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodyfulRoute<Target> {
        return LEOBodyfulRoute(path: path, method: method, body: body, against: base, headers: headers, statusCodes: statusCodes)
    }
    
    public func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodylessRoute<Target> {
        return LEOBodylessRoute(path: path, method: method, query: query, against: base, headers: headers, statusCodes: statusCodes)
    }
    
    public func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodyfulRoute<Target> {
        return LEOBodyfulRoute(path: path, method: method, body: body, against: base, headers: headers, statusCodes: statusCodes)
    }
}
