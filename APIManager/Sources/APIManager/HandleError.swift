import Foundation
import State

func handleError(response: URLResponse, data: Data) -> WithMeError? {
    let decoder = JSONDecoder()
    guard let httpResponse = response as? HTTPURLResponse else {
        return WithMeError.undefinedError
    }
    switch httpResponse.statusCode {
    case 0..<300:
        return nil
    case 400..<500:
        if let errorData = try? decoder.decode(ErrorData.self, from: data) {
            let error = WithMeError.userInitiatedError(errorData.error)
            return error
        } else {
            return WithMeError.undefinedError
        }
    default:
        return WithMeError.undefinedError
    }
}
