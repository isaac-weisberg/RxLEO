//
//  LEOListResponse.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

open class LEOListModel<Item: Decodable>: Decodable {
    public let items: [Item]
    
    // TODO: make clear whether if these are supposed to be optional or not
    public let nextCursor: String?
    public let prevCursor: String?
}

open class LEOListResponse<Item: Decodable>: LEOObjectResponse<LEOListModel<Item>> {
    
    /**
     The original implementation had an API that looked pretty much like this:
     
    public var data: [Item] {
        return self.data.items
    }
     
     Considering the fact that we are massively reusing the parsing behavior
     from the `LEOObjectResponse`, the data property is already successfully
     poiting to the `LEOListModel<Item>`, and thus is different.
     I could of course go on to implement the custom parsing logic
     so that the items of the `LEOListModel` become the actual value of `data`
     and the API perfectly reproduces the original behavior, however uhm no.
    */
    
    // TODO: document out this ^^^ behavior in the API migration guide.
    
    
    public var nextCursor: String? {
        return data.nextCursor
    }
    
    public var prevCursor: String? {
        return data.prevCursor
    }
}
