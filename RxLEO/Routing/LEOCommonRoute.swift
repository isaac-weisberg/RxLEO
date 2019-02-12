//
//  LEOCommonRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation

public protocol LEOCommonRoute {
    associatedtype Response: Decodable
    
    var url: URL { get }
    
    var headers: Headers? { get }
    
    var statusCodes: StatusCodes { get }
}
