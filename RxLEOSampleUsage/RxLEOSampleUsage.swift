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

/**
 First you would like to configure the common route to know agains which base should it assemble URLs.
 */
extension LEOCommonRoute {
    var endpoint: URL {
        #if DEBUG
            return URL(string: "http://localhost:8080/api/v1")!
        #else
            return URL(string: "http://188.22.12.164/api/v1")!
        #endif
    }
}

class News: Codable { }

/**
 Proceed to define routes
 */

enum NewsRoute {
    case prolongAuth(String)
    case update(News)
}

extension NewsRoute: LEOBodyfulRoute {
    var method: RxNick.MethodBodyful {
        switch self {
        case .update, .prolongAuth:
            return .post
        }
    }
    
    var body: RxNickRequestBody {
        switch self {
        case .update(let news):
            return RxNick.JsonBody(with: news) // One might be interested in encoding the body as json
        case .prolongAuth:
            return RxNick.VoidBody.void // One might also be interested in sending an empty body
        }
    }
    
    var path: String {
        switch self {
        case .update:
            return "news"
        case .prolongAuth:
            return "poke"
        }
    }
    
    var customHeaders: RxNick.Headers? { // There go the custom headers and auth
        switch self {
        case .update:
            return nil
        case .prolongAuth(let token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}

/**
 Since a body-less and body-ful request in RxNick is strictly separated,
 while utilizing the pattern of enum implementing the route protocol,
 you have to create a separate implementation for all of the body-less
 routes. This is there for a reason, most importantly - to prohibit you from
 shooting your own legs.
 */
extension NewsRoute {
    enum Gets {
        case all
        case paged(page: Int)
    }
}

extension NewsRoute.Gets: LEOBodylessRoute {
    var method: RxNick.MethodBodyless {
        switch self {
        case .all, .paged:
            return .get
        }
    }
    
    var query: RxNick.URLQuery? {
        switch self {
        case .all:
            return nil
        case .paged(let page):
            return [ "page": "\(page)" ] // URLQuery is a regular string to string dictionary
        }
    }
    
    var path: String {
        switch self {
        case .all, .paged:
            return "news"
        }
    }
}

/**
 And you're done setting up, now just use it like this.
 */

func usage() {
    let api: RxLEOAPIProvider = RxLEODefaultAPIProvider()
    
    let route = NewsRoute.Gets.all
    
    _ = api.request(route)
        .map { response -> LEOArrayResponse<News> in
            try response.json()
        }
        .subscribe(onSuccess: { news in
            print("Got me all the news, they is \(news)")
        }, onError: { error in
            print("Oh, shit, fuck", error)
        })
}
