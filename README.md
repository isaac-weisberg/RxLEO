# RxLEO
A Magora Systems' "Leopold API" implementation

## The primary goals of the project

1. Dispose of the ObjectMapper decoding capabilities, which have become obsolete since the ~~ascension of Jesus~~ fourth major version of swiftlang
1. Dispose of the Alamofire because it's fun to dispose of things and not fun to use the raw Alamofire
1. Provoke resolvation of major uncertainties in the API and it's numerous `// TODO:`s

## Project status

Tag 0.1 introduces Swift.Codable ports of the original LEONetworkingLayer project implementations of basic server response models. This pretty much means the formalization of the server interactions which are strictly defined by the API.

## Changes and migration from LEONetwrokingLayer

### Server responses model layer changes

- `LEOValueResponse` is absent in this implementation because it was obsoleted in the past
- `LEOListResponse`'s `data` field now points not to the array of the items parsed from the response, but to the `LEOListModel` instance. This has happened due to reusage of the `LEOObjectResponse`'s parsing implementation.  
Quick-fix: `data` ~> `data.items`

## Why should use Magora Systems' "Leopold API" in my projects?

For that very same reason we use any abstractions in this world. For the same reasons, operating systems were invented to remove the need to acknowledge the bare bones hardware, GUI were invented to remove the need to acknowledge the terminal, etc.  
It allows you to think less. And there is less need to coordinate with other project members since the API is utmost generic and covers a major slice of common REST API use cases (let alone paging, bitch). Itz vewy gud cos awwows fow de wapid dewewopment.