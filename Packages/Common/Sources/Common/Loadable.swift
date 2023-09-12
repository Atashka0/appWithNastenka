/// Позволяет следить за текущим состоянием объекта.
public enum Loadable<T> {
    case initial
    case loading
    case ready(T)
}

public extension Loadable {
    var data: T? {
        switch self {
        case let .ready(data):
            return data
        default:
            return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
