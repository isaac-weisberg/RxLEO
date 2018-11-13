//
//  LEOBodyfulRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxNick

public protocol LEOBodyfulRoute: LEOCommonRoute {
    var method: MethodBodyful { get }
    
    var body: RequestBody { get }
}
