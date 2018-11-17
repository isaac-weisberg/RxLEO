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
    public let endpoint: URL
    public let path: String
    public let method: MethodBodyless
    public let query: URLQuery?
    public let headers: Headers?
    public let statusCodes: StatusCodes
    
    init(path: String, method: MethodBodyless, query: URLQuery?, against url: URL, headers: Headers?, statusCodes: StatusCodes) {
        self.path = path
        self.method = method
        self.query = query
        self.endpoint = url
        self.headers = headers
        self.statusCodes = statusCodes
    }
}
