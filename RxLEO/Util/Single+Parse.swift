//
//  Single+.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/14/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxSwift

internal extension PrimitiveSequence where Trait == SingleTrait, Element: FreshResponse {
    func parse<Object: Decodable>() -> PrimitiveSequence<Trait, Response<Object>> {
        return map { response in
            try response.json()
        }
    }
}
