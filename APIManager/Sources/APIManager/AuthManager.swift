import Foundation
import State

/// Ходит в сеть за юзером
public class AuthManager {
    public init() {}
    
    public func registerUser(email: String, username: String, password: String) async -> Result<User?, Error> {
        let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.Route.register)")!
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.RESTMethod.post.rawValue
        request.addValue(APIConstants.HeaderValues.json.rawValue, forHTTPHeaderField: APIConstants.HeaderFields.contentType.rawValue)
        let userData = [APIConstants.email: email, APIConstants.username: username, APIConstants.password: password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let user = try? decoder.decode(User.self, from: data)
            return Result.success(user)
        } catch {
            return Result.failure(error)
        }
    }
    
    public func fetchUser(email: String, password: String) async -> Result<User?, Error> {
        let url = URL(string: "\(APIConstants.baseURL)/\(APIConstants.Route.login)")!
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.RESTMethod.post.rawValue
        request.addValue(APIConstants.HeaderValues.json.rawValue, forHTTPHeaderField: APIConstants.HeaderFields.contentType.rawValue)
        let userData = [APIConstants.email: email, APIConstants.password: password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            print(data)
            let user = try? decoder.decode(User.self, from: data)
            return Result.success(user)
        } catch {
            return Result.failure(error)
        }
    }
    
    public func logOut() async -> Result<Int, Error> {
        return Result.success(200)
    }
}
