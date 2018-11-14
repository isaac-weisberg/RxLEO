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

class News: Codable { }

/**
 Define the routes
 */
struct NewsRoute {
    /*
     Here, the Target object is defined as a generic parameter
     */
    static let all = LEOBodylessRoute<LEOArrayResponse<News>>(
        path: "all", // This is the path that is resolved against the `against` URL
        method: .get, // This is the HTTP method
        query: nil,
        against: URL(string: "http://apple.com")!) // The base server URL
    
    static func paged(at page: Int) -> LEOBodylessRoute<LEOListResponse<News>> {
        return LEOBodylessRoute(
            path: "paged",
            method: .get,
            query: [ URLQueryItem(name: "page", value: "\(page)") ], // Would you like to have a query appended to your URL?
            against: URL(string: "http://apple.com")!)
    }
}

//enum NewsRoute {
//    case prolongAuth(String)
//    case update(News)
//}
//
//extension NewsRoute: LEOBodyfulRoute {
//    var method: MethodBodyful {
//        switch self {
//        case .update, .prolongAuth:
//            return .post
//        }
//    }
//
//    var body: RequestBody {
//        switch self {
//        case .update(let news):
//            return RequestJsonBody(with: news) // One might be interested in encoding the body as json
//        case .prolongAuth:
//            return RequestVoidBody.void // One might also be interested in sending an empty body
//        }
//    }
//
//    var path: String {
//        switch self {
//        case .update:
//            return "news"
//        case .prolongAuth:
//            return "poke"
//        }
//    }
//
//    var customHeaders: Headers? { // There go the custom headers and auth
//        switch self {
//        case .update:
//            return nil
//        case .prolongAuth(let token):
//            return ["Authorization": "Bearer \(token)"]
//        }
//    }
//
//    // You use this to customize the validators logic
//    // when it comes down to validating response status codes
//    // RxNick has a whole own error object fro that case btw.
//    var expectedStatusCodes: StatusCodeRange {
//        switch self {
//        case .prolongAuth:
//            return [ 200..<300, 400..<401 ]
//        default:
//            return RxLEOStatusCodesDefaults // You can always fallback to defaults easily
//        }
//    }
//}
//
///**
// Since a body-less and body-ful request in RxNick is strictly separated,
// while utilizing the pattern of enum implementing the route protocol,
// you have to create a separate implementation for all of the body-less
// routes. This is there for a reason, most importantly - to prohibit you from
// shooting your own legs.
// */
//extension NewsRoute {
//    enum Gets {
//        case all
//        case paged(page: Int)
//    }
//}
//
//extension NewsRoute.Gets: LEOBodylessRoute {
//    var method: MethodBodyless {
//        switch self {
//        case .all, .paged:
//            return .get
//        }
//    }
//
//    var query: URLQuery? {
//        switch self {
//        case .all:
//            return nil
//        case .paged(let page):
//            return [
//                URLQueryItem(name: "page", value: "\(page)")
//            ] // RxNick.RxNick.URLQuery is an array of Foundation.URLQueryItem
//        }
//    }
//
//    var path: String {
//        switch self {
//        case .all, .paged:
//            return "news"
//        }
//    }
//}

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
