//
//  LEOError.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOError: Decodable {
    public var code: LEOApiErrorCode {
        return LEOApiErrorCode(raw: rawCode)
    }
    
    public let rawCode: String
    public let message: String
    public let field: String?
}
