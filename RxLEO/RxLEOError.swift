//
//  RxLEOError.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 3/16/19.
//  Copyright © 2019 Isaac Weisberg. All rights reserved.
//

public enum RxLEOError: Error {
    case auth
    case nick(NickError)
}
