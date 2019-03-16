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
    public func ensureStatusCode(in statusCodes: StatusCodes) -> RxNickResult<Void, NickError> {
        let code = res.statusCode
        guard statusCodes.contain(statusCode: code) else {
            return .failure(NickError.statusCode(code, statusCodes))
        }
        return .success(())
    }
}

public class FreshResponse: ResponsePrimitive {
    public let res: HTTPURLResponse
    public let data: Data?
    
    init(res: HTTPURLResponse, data: Data?) {
        self.res = res
        self.data = data
    }
    
    public func json<Target: Decodable>() -> RxNickResult<Response<Target>, NickError> {
        return ensureData()
            .map { data in
                let decoder = JSONDecoder()
                let target: Target
                
                do {
                    target = try decoder.decode(Target.self, from: data)
                } catch {
                    return .failure(NickError.parsing(error))
                }
                return .success((data: data, target: target))
            }
            .map { (stuff: (data: Data, target: Target)) in
                .success(Response(res: res, data: stuff.data, target: stuff.target))
            }
    }
    
    public func ensureData() -> RxNickResult<Data, NickError> {
        guard let data = data else {
            return .failure(NickError.expectedData)
        }
        return .success(data)
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
