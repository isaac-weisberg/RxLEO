//
//  LEOBodyfulRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxNick

public class LEOBodyfulRoute<Response: Decodable>: LEOCommonRoute {
    public let endpoint: URL
    public let path: String
    public let method: MethodBodyful
    public let body: RequestBody
    
    public init(path: String, method: MethodBodyful, body: RequestBody, against url: URL) {
        self.path = path
        self.method = method
        self.body = body
        self.endpoint = url
    }
}
