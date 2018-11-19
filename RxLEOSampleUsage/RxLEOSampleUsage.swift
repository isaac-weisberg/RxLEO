//
//  RxLEOSampleUsage.swift
//  RxLEOSampleUsage
//
//  Created by Isaac Weisberg on 11/11/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import Foundation
import RxLEO
import RxNick


/*
 The models in your application might look something like dis
 */
class News: Codable { }




/**
 Define the router with the base URL against which every single route path will be resolved.
 */
#if DEBUG
    let router = LEORouter(against: URL(string: "https://dev.meproj.net/api/v1")!)
#else
    let router = LEORouter(against: URL(string: "https://meproj.net/api/v1")!)
#endif




/**
 Define the routes
 */
struct NewsRoute {
    static let all = router.bodyless(
        path: "news", // This is the path that is resolved against the `against` URL
        method: .get, // This is the HTTP method
        query: nil,
        response: LEOArrayResponse<News>.self) // The expected response type
    
    
    /**
     In case if it's gonna be easy for compiler (and for you) to deduct the response type,
     you are free to not to supply the last parameter
    */
    static func paged(at page: Int) -> LEOBodylessRoute<LEOListResponse<News>> {
        return router.bodyless(
            path: "news/paged",
            method: .get,
            query: [ URLQueryItem(name: "page", value: "\(page)") ],
            // ^^^ Would you like to have a query appended to your URL?
            headers: [ "Content-Type": "application/human/dick" ]
        )
    }
    
    
    /**
     Oh, how about a post request?
     */
    static func create(_ news: News) -> LEOBodyfulRoute<LEOBaseResponse> {
        return router.bodyful(
            path: "news",
            method: .post,
            body: RequestJsonBody(with: news))
    }
    
    static let shitPenis = router.bodyful(
        path: "", // Might want to point to the base url
        method: .post,
        body: RequestVoidBody.void, // Might want to have no request body
        response: LEOBaseResponse.self)
    
    /**
     You can supply non-leo model
     You can also supply `RequestRawBody`
     
     Here headers in the `headers` field
     are not related to anything and override
     anything that was supplied by RxLEO or
     RxNick frameworks as well as anything
     that was produced by this routes body object.
     
     You can supply a custom policy for statusCodes validation.
    */
    static let customs = router.bodyful(
        path: "customs/things",
        method: .post,
        body: RequestRawBody(
            data: "Fuck you, stupid ass server".data(using: .utf8)!,
            headers: [ "User-Agent": "MS-DOS 6.2 AMD286 3MB" ]), // These headers are related to the logic of producing a serialized body.
        response: News.self,
        headers: [ "Penis-Length" : "9000" ],
        statusCodes: [ 200, 350..<200, 600..., ...100 ]
    )
}




/**
 And you're done setting up, now just use it like this.
 */
func usage() {
    let api: RxLEOAPIProvider = RxLEODefaultAPIProvider()
    
    let route = NewsRoute.paged(at: 3)
    
    _ = api.request(route)
        .subscribe(onSuccess: { news in
            print("Got me all the news, they is \(news.target)")
        }, onError: { error in
            print("Oh, shit, fuck", error)
        })
}



/**
 Bonus rounds:
 */

/**
 Given
 */
class CursorQuery {
    let page: Int
    let size: Int
    
    init(page: Int, size: Int = 10) {
        self.page = page
        self.size = size
    }
    
    var next: CursorQuery {
        return CursorQuery(page: page + 1, size: size)
    }
}

/**
 One can
 */
extension CursorQuery: URLQuery {
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "size", value: "\(size)")
        ]
    }
}

/**
 And then
 */
func asdf() {
    func getSomePaged(at index: Int) -> LEOBodylessRoute<LEOBaseResponse> {
        return router.bodyless(path: "someshit", method: .get, query: CursorQuery(page: 0))
    }
    
    let api = RxLEODefaultAPIProvider()
    
    _ = api.request(getSomePaged(at: 0))
}
