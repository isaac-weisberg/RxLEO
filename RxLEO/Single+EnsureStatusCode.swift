//
//  Single+EnsureStatusCode.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/13/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxSwift
import RxNick

internal extension PrimitiveSequence where Trait == SingleTrait, Element: RxNick.Response {
    func ensureStatusCode(in range: Range<Int>) -> Single<Element> {
        return self
            .do(onSuccess: { response in
                try response.ensureStatusCode(in: range)
            })
    }
}
