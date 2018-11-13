//
//  LEOCommonRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxNick

public protocol LEOCommonRoute {
    /**
     This is the base endpoint of the server.
     The proper usage is to define in a project
     dependent on this framework a default extension
     which will return the endpoint pointing to the
     root of the Leopold API.
     
     For instance, https://meproject.com/api/v1/
     */
    var endpoint: URL { get }
    
    /**
     This string specifies a path relative
     to the endpoint inside the API.
     
     Commonly, it's just appended to the endpoint
     */
    var path: String { get }
    
    /**
     This getter will be used to get the actual URL,
     with endpoint and path being taken into account.
     */
    var assembledUrl: URL { get }
    
    var customHeaders: Headers? { get }
    
    var expectedStatusCodes: StatusCodeRangeUnion { get }
}

public extension LEOCommonRoute {
    var assembledUrl: URL {
        return endpoint.appendingPathComponent(path)
    }
    
    var customHeaders: Headers? {
        return nil
    }
    
    /**
     Default LEO-compliant response status codes
     */
    var expectedStatusCodes: StatusCodeRangeUnion {
        return RxLEOStatusCodesDefaults
    }
}
