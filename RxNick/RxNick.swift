//
//  RxNick.swift
//  RxNick
//
//  Created by Isaac Weisberg on 10/27/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxSwift

func jsonEncode<Body: Encodable>(_ body: Body) throws -> Data {
    do {
        return try JSONEncoder().encode(body)
    } catch {
        throw NickError.parsing(error)
    }
}

extension URL {
    func appending(query: URLQuery) -> URL {
        let optionalComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        assert(optionalComponents != nil, "This means that the user has applied a URL with malformed URL string. I literally have no idea what it means, and at this point idc.")
        var components = optionalComponents!
        var urlQuery = components.queryItems ?? []
        urlQuery.append(contentsOf: query.queryItems)
        components.queryItems = urlQuery
        let resultingUrl = components.url
        assert(resultingUrl != nil, "This means that a url was poiting into the file:// scheme and the path was not absolute. Since it's a networking framework, please don't use it to work with the file system")
        return resultingUrl!
    }
}

public enum MethodBodyless: String {
    case get = "GET"
}

public enum MethodBodyful: String {
    case post = "POST"
}

public enum NickError: Error {
    case parsing(Error)
    case encoding(Error)
    case expectedData
    case networking(Error)
    case statusCode(Int, StatusCodes)
}

public protocol RequestBody {
    /**
     `data` method optionaly produces the Data object of
     the request body. In case of an error being thrown by the
     implementation of this method, it gets force wrapped
     into RxNick.NickError.encoding and this its unity
     compliance is not required.
     */
    func data() throws -> Data?
    
    /**
     Same this with this method: if an error is thrown,
     it's wrapped into RxNick.NickError.encoding
     */
    func headers() throws -> Headers?
}

public class RequestJsonBody<Object: Encodable>: RequestBody {
    public func headers() throws -> Headers? {
        return ["Content-Type": "application/json"]
    }
    
    public func data() throws -> Data? {
        return try JSONEncoder().encode(object)
    }
    
    let object: Object
    
    public init(with object: Object) {
        self.object = object
    }
}

public class RequestRawBody: RequestBody {
    public func data() throws -> Data? {
        return actualData
    }
    
    public func headers() throws -> Headers? {
        return actualHeaders
    }
    
    let actualData: Data?
    let actualHeaders: Headers?
    
    public init(data: Data?, headers: Headers? = nil) {
        actualHeaders = headers
        actualData = data
    }
}

public class RequestVoidBody: RequestBody {
    public func headers() throws -> Headers? {
        return nil
    }
    
    public func data() throws -> Data? {
        return nil
    }
    
    public static let void = RequestVoidBody()
}


public typealias Headers = [String: String]
public typealias MethodFactory = () throws -> String
public typealias HeadersFactory = () throws -> Headers
public typealias URLFactory = () throws -> URL
typealias HeaderMigrationStrat = (Headers.Value, Headers.Value) -> Headers.Value

public class RxNick {
    let session: URLSession
    
    public init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func request(methodFactory: @escaping MethodFactory, urlFactory: @escaping URLFactory, headersFactory: HeadersFactory?, body: RequestBody? = nil) -> Single<FreshResponse> {
        return Single.create {[session = session] single in
            let migrationStrat: HeaderMigrationStrat = { $1 }
            
            let request: URLRequest
            
            do {
                let url = try urlFactory()
                
                var req = URLRequest(url: url)
                req.httpMethod = try methodFactory()
                
                req.httpBody = try body?.data()
                
                var allHeaders: Headers = [:]
                
                if let bodyHeaders = try body?.headers() {
                    allHeaders.merge(bodyHeaders, uniquingKeysWith: migrationStrat)
                }
                
                if let customHeaders = try headersFactory?() {
                    allHeaders.merge(customHeaders, uniquingKeysWith: migrationStrat)
                }
                
                req.allHTTPHeaderFields = allHeaders
                
                request = req
            } catch {
                single(.error(NickError.encoding(error)))
                return Disposables.create()
            }
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.error(NickError.networking(error)))
                    return
                }
                
                assert(response is HTTPURLResponse, "Since the api used in this callback is the dataTask API, as per Apple docs, this object is always the HTTPURLResponse and thus this assertion.")
                let response = response as! HTTPURLResponse
                let resp = FreshResponse(res: response, data: data)
                single(.success(resp))
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    public func bodylessRequest(_ method: MethodBodyless, _ url: URL, query: URLQuery?, headers: Headers?) -> Single<FreshResponse> {
        return request(
            methodFactory: { method.rawValue },
            urlFactory: {
                guard let query = query else {
                    return url
                }
                return url.appending(query: query)
            },
            headersFactory: buildHeadersFactory(from: headers)
        )
    }
    
    public func bodyfulRequest(_ method: MethodBodyful, _ url: URL, body: RequestBody, headers: Headers?) -> Single<FreshResponse> {
        return request(
            methodFactory: { method.rawValue },
            urlFactory: { url },
            headersFactory: buildHeadersFactory(from: headers),
            body: body
        )
    }
}

private func buildHeadersFactory(from headers: Headers?) -> HeadersFactory? {
    var headersFactory: HeadersFactory?
    if let headers = headers {
        headersFactory = { headers }
    }
    return headersFactory
}
