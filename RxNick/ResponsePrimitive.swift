//
//  ResponsePrimitive.swift
//  RxNick
//
//  Created by Isaac Weisberg on 11/14/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation

public protocol ResponsePrimitive {
    var res: HTTPURLResponse { get }
}

public extension ResponsePrimitive {
    public func ensureStatusCode(in statusCodes: StatusCodes) throws {
        let code = res.statusCode
        guard statusCodes.contain(statusCode: code) else {
            throw NickError.statusCode(code, statusCodes)
        }
    }
}

public class FreshResponse: ResponsePrimitive {
    public let res: HTTPURLResponse
    public let data: Data?
    
    init(res: HTTPURLResponse, data: Data?) {
        self.res = res
        self.data = data
    }
    
    public func json<Target: Decodable>() throws -> Response<Target> {
        let data = try ensureData()
        let decoder = JSONDecoder()
        let target: Target
        do {
            target = try decoder.decode(Target.self, from: data)
        } catch {
            throw NickError.parsing(error)
        }
        return Response(res: res, data: data, target: target)
    }
    
    public func ensureData() throws -> Data {
        guard let data = data else {
            throw NickError.expectedData
        }
        return data
    }
}

public class Response<Target: Decodable>: ResponsePrimitive {
    public let res: HTTPURLResponse
    public let data: Data
    public let target: Target
    
    init(res: HTTPURLResponse, data: Data, target: Target) {
        self.res = res
        self.data = data
        self.target = target
    }
}
