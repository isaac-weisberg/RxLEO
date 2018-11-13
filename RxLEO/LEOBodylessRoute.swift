//
//  LEOBodylessRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxNick

public protocol LEOBodylessRoute: LEOCommonRoute {
    var method: MethodBodyless { get }
    
    var query: URLQuery? { get }
}
