import Foundation

open class LEOMediaResource: Decodable {
    public let id: String
    public let originalUrl: URL
    public let contentType: String?
    public let formatUrls: [String: String]?
}
