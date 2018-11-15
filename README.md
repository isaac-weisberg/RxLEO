# RxLEO
A Magora Systems' "Leopold API" implementation

## The primary goals of the project

1. Dispose of the ObjectMapper decoding capabilities, which have become obsolete since the ~~ascension of Jesus~~ fourth major version of swiftlang
1. Dispose of the Alamofire because it's fun to dispose of things and not fun to use the raw Alamofire
1. Provoke resolvation of major uncertainties in the API and it's numerous `// TODO:`s

## Note

The project maintains a sample usage source file which can be found in ./RxLEOSampleUsage which pretty much covers 95% of usage cases.

## Project status

Tag 0.1 introduces Swift.Codable ports of the original LEONetworkingLayer project implementations of basic server response models. This pretty much means the formalization of the server interactions which are strictly defined by the API.

Tag 0.2 introduces RxNick implementation of routing capabilities and an interface that provides the exchange between routing objects and RxNick's response primitives. The routing is heavily reminiscent of what it looked like in the original implementation.

Tag 0.3 heavily reworks the routing part of the original implementation and relies on a more mature version of RxNick. One of the most notable changes are that a route object can now provide a range of status codes to validate against, the expexted response object declaration is not merged into the declaration of a route, the route definition, and well as base URL definitions, have become tons of times shorter. However, in this one using enums as routes is not supported unless you want the all to return the same type of object.

## Changes and migration from LEONetworkingLayer

### Server responses model layer changes

- `LEOValueResponse` is absent in this implementation because it was obsoleted in the past.  
Quick-fix: `LEOValueResponse` ~> `LEOObjectResponse`
- `LEOListResponse`'s `data` field now points not to the array of the items parsed from the response, but to the `LEOListModel` instance. This has happened due to reusage of the `LEOObjectResponse`'s parsing implementation.  
Quick-fix: `data` ~> `data.items`

### Routing layer changes

RxNick plugs a concept of strict diversity of a route that is supposed to have a body and one that is supposed to have a url query. This is REST and ortodox, however, might be changed. In the original implementation-- I don't even fucking remember what there was, but there was a similar pattern where you
1. Defined an enum of routes, mapping 1 to 1 to business-logic endpoints, taking in count method, body, headers and urls-- complete dynamysm
1. Make sure the enum implements the `LEORoute` protocol
1. Pass a `LEORoute` object to a ugh a RxSwift-above-Alamofire wrapper which I have pretty surely seen outside the original framework repo and in local application projects

With this implementation, it's pretty much the same, but
- There are 2 protocols that you implement separately, with different enums. Yep, sorry, but it guarantees that you are not shooting your legs. Those protocols are `LEOBodyfulRoute` and `LEOBodylessRoute`
- You pass a route object to a `RxLEOAPIProvider`

### Networking layer changes

Pretty much everything is new. There is now `RxLEOAPIProvider` protocol and its default RxNick-based implementation called `RxLEODefaultAPIProvider`. This separation allows for API stubbing which is good for clients testability. So the common usage strategy, briefly is:
1. Manage an instance of `RxLEOAPIProvider` somewhere in the client's architecture
1. Manage a `LEORouter` which is resposible for currying all routes' protocols creation against a base URL 
1. Create a `LEOBodyfulRoute` or `LEOBodylessRoute` using `LEORouter`'s methods
1. Push such object to one of the `RxLEOAPIProvider.request` methods, which will produce a `RxSwift.Single<RxNick.Response>`
1. The actual model that you are supposing to retrieve should already be parsed and present in the `Response`'s `target` property.

## Why should I use Magora Systems' "Leopold API" in my projects?

For that very same reason we use any abstractions in this world. For the same reasons, operating systems were invented to remove the need to acknowledge the bare bones hardware, GUI were invented to remove the need to acknowledge the terminal, etc.  
It allows you to think less. And there is less need to coordinate with other project members since the API is utmost generic and covers a major slice of common REST API use cases (let alone paging, bitch). Itz vewy gud cos awwows fow de wapid dewewopment.
