//
//  StatusCodes.swift
//  RxNick
//
//  Created by Isaac Weisberg on 11/16/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

public protocol StatusCodes {
    func contain(statusCode: Int) -> Bool
}

extension Int: StatusCodes {
    public func contain(statusCode: Int) -> Bool {
        return self == statusCode
    }
}

extension Array: StatusCodes where Element == StatusCodes {
    public func contain(statusCode: Int) -> Bool {
        return self.contains { $0.contain(statusCode: statusCode) }
    }
}

extension Range: StatusCodes where Bound == Int {
    public func contain(statusCode: Int) -> Bool {
        return contains(statusCode)
    }
}

extension ClosedRange: StatusCodes where Bound == Int {
    public func contain(statusCode: Int) -> Bool {
        return contains(statusCode)
    }
}

extension PartialRangeFrom: StatusCodes where Bound == Int {
    public func contain(statusCode: Int) -> Bool {
        return contains(statusCode)
    }
}

extension PartialRangeThrough: StatusCodes where Bound == Int {
    public func contain(statusCode: Int) -> Bool {
        return contains(statusCode)
    }
}

extension PartialRangeUpTo: StatusCodes where Bound == Int {
    public func contain(statusCode: Int) -> Bool {
        return contains(statusCode)
    }
}
