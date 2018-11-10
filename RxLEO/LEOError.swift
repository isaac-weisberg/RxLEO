//
//  LEOError.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOError: Decodable {
    // The actuall error code can be outside of the known set of enum values
    // and thus, a case for a custom value must exist
    // TODO: support custom errors
    public var code: LEOApiErrorCode? {
        return LEOApiErrorCode(rawValue: self.rawCode)
    }
    
    public let rawCode: String
    public let message: String
    public let field: String?
}
