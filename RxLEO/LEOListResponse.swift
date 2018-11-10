//
//  LEOListResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOListModel<Item: Decodable>: Decodable {
    public let items: [Item]
    public let nextCursor: String?
    public let prevCursor: String?
}

open class LEOListResponse<Item: Decodable>: LEOObjectResponse<LEOListModel<Item>> {
    
}
