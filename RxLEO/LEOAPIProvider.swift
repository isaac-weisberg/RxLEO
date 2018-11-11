//
//  LEOAPIProvider.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxSwift
import RxNick

public protocol LEOAPIProvider {
    func request(_ route: LEOBodyfulRoute) -> Single<RxNick.Response>
    
    func request(_ route: LEOBodylessRoute) -> Single<RxNick.Response>
}
