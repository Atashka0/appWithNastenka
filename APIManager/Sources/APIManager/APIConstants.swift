struct APIConstants {
    public static let baseURL: String = "http://127.0.0.1:5000"
    static let resultDescription: String = "message"
    static let email: String = "email"
    static let password: String = "password"
    static let username: String = "username"
    static let place: String = "place"
    static let eventName: String = "eventName"
    static let eventDescription: String = "eventDescription"
    static let characteristics: String = "characteristics"
    static let participants: String = "participants"
    
    enum RESTMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum HeaderFields: String {
        case contentType = "Content-Type"
    }
    
    enum HeaderValues: String {
        case json = "application/json"
    }
    
    enum Route: String {
        case register
        case login
    }
}
