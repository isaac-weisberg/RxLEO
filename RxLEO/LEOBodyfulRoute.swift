//
//  LEOBodyfulRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxNick

protocol LEOBodyfulRoute: LEOCommonRoute {
    var method: RxNick.MethodBodyful { get }
    
    var body: RxNickRequestBody { get }
}
