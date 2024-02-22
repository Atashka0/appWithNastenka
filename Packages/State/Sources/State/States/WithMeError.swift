public enum WithMeError: Error, Equatable {
    case userInitiatedError(String)
    case undefinedError
}
