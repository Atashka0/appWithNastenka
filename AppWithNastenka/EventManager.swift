import Foundation
import State
import AuthManager

public class EventManager {
    public static func newEvent(event: Event) async -> Result<Event?, Error> {
        let data = toJSON(event)
        
        if let jsonString = String(data: data!, encoding: .utf8) {
            print(jsonString)
        }
        
        
        var request = URLRequest(url: URL(string: "\(APIConstants.baseURL)/newEvent")!)
        request.httpMethod = APIConstants.RESTMethod.post.rawValue
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            print(data)
            let event = try? decoder.decode(Event.self, from: data)
            return Result.success(event)
        } catch {
            return Result.failure(error)
        }
    }
}

