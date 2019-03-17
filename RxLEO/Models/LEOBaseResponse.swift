//
//  LEOBaseResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOBaseResponse: Decodable {
    public let code: LEOApiGlobalErrorCode
}

public extension LEOBaseResponse {
    public var isSuccess: Bool {
        return code == .success
    }
}
