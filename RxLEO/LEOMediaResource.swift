//
//  LEOMediaResource.swift
//  RxLEO
//
//  Created by Isaac Weisberg on 11/10/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation

open class LEOMediaResource: Decodable {
    public let id: String
    public let originalUrl: URL
    public let contentType: String?
    public let formatUrls: [String: String]?
}
