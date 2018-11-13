//
//  LEOError.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOError: Decodable {
    public let rawCode: LEOApiErrorCode
    public let message: String
    public let field: String?
}
