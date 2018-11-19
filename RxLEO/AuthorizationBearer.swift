//
//  AuthorizationBearer.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/19/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

public func AuthorizationBearer(token: String) -> [String: String] {
    return [
        "Authorization": "Bearer \(token)"
    ]
}
