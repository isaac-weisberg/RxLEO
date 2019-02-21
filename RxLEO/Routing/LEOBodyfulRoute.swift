//
//  LEOBodyfulRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation

public class LEOBodyfulRoute<Response: Decodable>: LEOCommonRoute {
    public var url: URL {
        return base.appendingPathComponent(path)
    }
    
    public let base: URL
    public let path: String
    public let method: MethodBodyful
    public let body: RequestBody
    public let headers: Headers?
    public let statusCodes: StatusCodes
    public let mutator: ((URLRequest) -> URLRequest)?
    
    init(path: String, method: MethodBodyful, body: RequestBody, against base: URL, headers: Headers?, statusCodes: StatusCodes, mutator: ((URLRequest) -> URLRequest)?) {
        self.path = path
        self.method = method
        self.base = base
        self.body = body
        self.headers = headers
        self.statusCodes = statusCodes
        self.mutator = mutator
    }
}
