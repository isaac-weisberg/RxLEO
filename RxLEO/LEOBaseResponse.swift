//
//  LEOBaseResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOBaseResponse: Decodable {
    public let code: LEOApiGlobalErrorCode
    public let message: String?
    public let errors: [LEOError]?
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(LEOApiGlobalErrorCode.self, forKey: .code)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        errors = try container.decodeIfPresent([LEOError].self, forKey: .errors)
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case errors
    }
}

public extension LEOBaseResponse {
    public var isSuccess: Bool {
        return code == .success
    }
}
