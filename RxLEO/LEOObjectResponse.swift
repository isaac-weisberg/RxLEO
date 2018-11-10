//
//  LEOObjectResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOObjectResponse<Object: Decodable>: LEOBaseResponse {
    public let data: Object
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ObjectCodingKeys.self)
        data = try container.decode(Object.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    enum ObjectCodingKeys: String, CodingKey {
        case data
    }
}
