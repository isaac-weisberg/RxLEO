public enum RxNickResult<Value, Error> {
    case success(Value)
    case failure(Error)
}

public extension RxNickResult {
    func map<NewValue>(_ predicate: (Value) -> RxNickResult<NewValue, Error>) -> RxNickResult<NewValue, Error> {
        switch self {
        case .success(let val):
            return predicate(val)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    func mapError<NewError>(_ predicate: (Error) -> RxNickResult<Value, NewError>) -> RxNickResult<Value, NewError> {
        switch self {
        case .success(let val):
            return .success(val)
        case .failure(let err):
            return predicate(err)
        }
    }
}
