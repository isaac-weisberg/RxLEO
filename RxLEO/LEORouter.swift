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
    
    public func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, response: Target.Type) -> LEOBodylessRoute<Target> {
        return LEOBodylessRoute(path: path, method: method, query: query, against: base)
    }
    
    public func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, response: Target.Type) -> LEOBodyfulRoute<Target> {
        return LEOBodyfulRoute(path: path, method: method, body: body, against: base)
    }
    
    public func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?) -> LEOBodylessRoute<Target> {
        return LEOBodylessRoute(path: path, method: method, query: query, against: base)
    }
    
    public func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody) -> LEOBodyfulRoute<Target> {
        return LEOBodyfulRoute(path: path, method: method, body: body, against: base)
    }
}
