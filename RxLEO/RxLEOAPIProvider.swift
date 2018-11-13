//
//  RxLEOAPIProvider.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxSwift
import RxNick

public protocol RxLEOAPIProvider {
    func request(_ route: LEOBodyfulRoute) -> Single<Response>
    
    func request(_ route: LEOBodylessRoute) -> Single<Response>
}
