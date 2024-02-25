import Foundation
import State

/// Ходит в сеть за юзером
public class AuthManager {
    public init() {}
    
    public func registerUser(_ user: User, password: String) async -> Result<User?, Error> {
        let data = toJSON([
            APIConstants.username: user.username,
            APIConstants.email: user.email,
            APIConstants.password: password
        ])
        
        if let jsonString = String(data: data!, encoding: .utf8) {
            print(jsonString)
        }
        
        var request = URLRequest(url: URL(string: APIConstants.baseURL + APIConstants.Handles.register.rawValue)!)
        request.httpMethod = APIConstants.RESTMethod.post.rawValue
        request.httpBody = data
        request.setValue(APIConstants.HeaderValues.json.rawValue, forHTTPHeaderField: APIConstants.HeaderFields.contentType.rawValue)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let error = handleError(response: response, data: data) {
                return Result.failure(error)
            }
            
            print(String(decoding: data, as: UTF8.self))
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                return Result.success(user)
            } else {
                return Result.failure(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Could not decode data")))
            }
        } catch {
            return Result.failure(error)
        }
    }
    
    public func fetchUser(email: String, password: String) async -> Result<User?, Error> {
        let data = toJSON([
            APIConstants.email: email,
            APIConstants.password: password
        ])
        
        if let jsonString = String(data: data!, encoding: .utf8) {
            print(jsonString)
        }
        
        var request = URLRequest(url: URL(string: APIConstants.baseURL + APIConstants.Handles.login.rawValue)!)
        request.httpMethod = APIConstants.RESTMethod.post.rawValue
        request.httpBody = data
        request.setValue(APIConstants.HeaderValues.json.rawValue, forHTTPHeaderField: APIConstants.HeaderFields.contentType.rawValue)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let error = handleError(response: response, data: data) {
                return Result.failure(error)
            }
            
            print(String(decoding: data, as: UTF8.self))
            let decoder = JSONDecoder()
            let user = try? decoder.decode(User.self, from: data)
            return Result.success(user)
        } catch {
            return Result.failure(error)
        }
    }
}
