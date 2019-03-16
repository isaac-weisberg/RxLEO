//
//  LEOCommonRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation

public protocol LEOAbstractRoute {
    var url: URL { get }
    
    var headers: Headers? { get set }
    
    var statusCodes: StatusCodes { get }
}

public protocol LEOCommonRoute: LEOAbstractRoute {
    associatedtype Response: Decodable
}
