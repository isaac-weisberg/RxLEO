public enum LEOApiGlobalErrorCode: String, Decodable {
    case success = "success"
    case businessConflict = "business_conflict"
    case unprocessableEntity = "unprocessable_entity"
    case badParameters = "bad_parameters"
    case internalError = "internal_error"
    case notFound = "not_found"
    case securityError = "security_error"
    case permissionError = "permission_error"
    case unknown = "Unknown"
}
