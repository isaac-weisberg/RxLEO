public enum LEOApiErrorCode {
    
    case unknown(String)
    case invalidAuthData
    case loginShouldBeConfirmed
    case refreshTokenInvalid
    case accessTokenInvalid
    case accessTokenExpired
    case passCodeNotValid
    
    case fieldNotBlank
    case fieldSizeMax
    case fieldSizeMin
    case fieldInvalidLength
    case fieldNotValidChars
    case fieldNumberMax
    case fieldNumberMin
    case fieldFuture
    case fieldPast
    case emailNotValid
    case cardNumberNotValid
    case phoneNumberNotValid
    case fieldDuplicate
    
    
    init(raw string: String) {
        self = [
            "sec.invalid_auth_data": LEOApiErrorCode.invalidAuthData,
            "sec.login_should_be_confirmed": LEOApiErrorCode.loginShouldBeConfirmed,
            "sec.refresh_token_invalid": LEOApiErrorCode.refreshTokenInvalid,
            "sec.access_token_invalid": LEOApiErrorCode.accessTokenInvalid,
            "sec.access_token_expired": LEOApiErrorCode.accessTokenExpired,
            "sec.pass_code_not_valid": LEOApiErrorCode.passCodeNotValid,
            
            "common.field_not_blank": LEOApiErrorCode.fieldNotBlank,
            "common.field_size_max": LEOApiErrorCode.fieldSizeMax,
            "common.field_size_min": LEOApiErrorCode.fieldSizeMin,
            "common.field_invalid_length": LEOApiErrorCode.fieldInvalidLength,
            "common.field_not_valid_chars": LEOApiErrorCode.fieldNotValidChars,
            "common.field_max": LEOApiErrorCode.fieldNumberMax,
            "common.field_min": LEOApiErrorCode.fieldNumberMin,
            "common.field_future": LEOApiErrorCode.fieldFuture,
            "common.field_past": LEOApiErrorCode.fieldPast,
            "common.field_email": LEOApiErrorCode.emailNotValid,
            "common.field_card_number": LEOApiErrorCode.cardNumberNotValid,
            "common.field_phone": LEOApiErrorCode.phoneNumberNotValid,
            "common.field_duplicate": LEOApiErrorCode.fieldDuplicate,
        ][string] ?? .unknown(string)
    }
}
