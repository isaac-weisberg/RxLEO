//
//  Single+.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/14/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import RxSwift
import RxNick

internal extension PrimitiveSequence where Trait == SingleTrait, Element: Response {
    func parse<Object: Decodable>() -> PrimitiveSequence<Trait, Object> {
        return map { response in
            try response.json()
        }
    }
}
