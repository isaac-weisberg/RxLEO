//
//  LEOBodylessRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxNick

public class LEOBodylessRoute<Response: Decodable>: LEOCommonRoute {
    public var url: URL {
        return base.appendingPathComponent(path)
    }
    
    public let base: URL
    public let path: String
    public let method: MethodBodyless
    public let query: URLQuery?
    public let headers: Headers?
    public let statusCodes: StatusCodes
    
    init(path: String, method: MethodBodyless, query: URLQuery?, against base: URL, headers: Headers?, statusCodes: StatusCodes) {
        self.path = path
        self.method = method
        self.query = query
        self.base = base
        self.headers = headers
        self.statusCodes = statusCodes
    }
}
