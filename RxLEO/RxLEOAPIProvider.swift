//
//  RxLEOAPIProvider.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxSwift

public protocol RxLEOAPIProvider {
    func request<Target: Decodable>(_ route: LEOBodyfulRoute<Target>) -> Single<RxNickResult<Response<Target>, RxLEOError>>
    
    func request<Target: Decodable>(_ route: LEOBodylessRoute<Target>) -> Single<RxNickResult<Response<Target>, RxLEOError>>
}
