//
//  LEOErrorResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 3/17/19.
//  Copyright © 2019 Isaac Weisberg. All rights reserved.
//

public class LEOErrorResponse: LEOBaseResponse {
    public let message: String
    public let errors: [LEOError]
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ErrorKeys.self)
        message = try container.decode(String.self, forKey: .message)
        errors = try container.decode([LEOError].self, forKey: .errors)
        try super.init(from: decoder)
    }
    
    enum ErrorKeys: String, CodingKey {
        case message
        case errors
    }
}
