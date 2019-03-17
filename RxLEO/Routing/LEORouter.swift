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

public protocol LEORouterAuthedDelegate: class {
    func getAccessToken() -> String
    
    func getRefreshToken() -> String
    
    func update(accessToken: String)
    
    func set(accessToken: String, refreshToken: String)
}

public class LEORouterAuthed: LEORouter {
    public unowned let delegate: LEORouterAuthedDelegate
    
    init(against url: URL, delegate: LEORouterAuthedDelegate) {
        self.delegate = delegate
        super.init(against: url)
    }
    
    func auth(headers: [String: String]?) -> [String: String] {
        let auth = AuthorizationBearer(token: delegate.getAccessToken())
        return headers?.merging(auth) { $1 } ?? auth
    }
    
    public override func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, response: Target.Type, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodylessRoute<Target> {
        return super.bodyless(path: path, method: method, query: query, response: response,
                        headers: auth(headers: headers), statusCodes: statusCodes)
    }
    
    public override func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, response: Target.Type, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodyfulRoute<Target> {
        return super.bodyful(path: path, method: method, body: body, response: response,
                         headers: auth(headers: headers), statusCodes: statusCodes)
    }
    
    public override func bodyless<Target: Decodable>(path: String, method: MethodBodyless, query: URLQuery?, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodylessRoute<Target> {
        return super.bodyless(path: path, method: method, query: query,
                              headers: auth(headers: headers), statusCodes: statusCodes)
    }
    
    public override func bodyful<Target: Decodable>(path: String, method: MethodBodyful, body: RequestBody, headers: Headers? = nil, statusCodes: StatusCodes = RxLEOStatusCodesDefaults) -> LEOBodyfulRoute<Target> {
        return super.bodyful(path: path, method: method, body: body,
                             headers: auth(headers: headers), statusCodes: statusCodes)
    }
}
