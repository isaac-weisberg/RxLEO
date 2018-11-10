//
//  LEOBodyfulRoute.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxNick

protocol LEOBodyfulRouter: CommonLEORoute {
    var method: RxNick.MethodBodyful { get }
}
