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
    func request<Route: LEOBodyfulRoute>(_ route: Route) -> Single<Response<Route.Response>>
    
    func request<Route: LEOBodylessRoute>(_ route: Route) -> Single<Response<Route.Response>>
}
