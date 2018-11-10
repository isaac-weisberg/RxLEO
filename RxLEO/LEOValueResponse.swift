//
//  LEOValueResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOValueResponse<Value: Decodable>: LEOBaseResponse {
    public let data: Value
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ValueCodingKeys.self)
        data = try container.decode(Value.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    enum ValueCodingKeys: String, CodingKey {
        case data
    }
}
