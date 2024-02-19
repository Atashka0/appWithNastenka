import Foundation
import State

/// Ходит в сеть за ивентами
public class EventManager {
    public init() {}
    
    public func newEvent(_ event: Event) async -> Result<Event, Error> {
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
            if let event = try? decoder.decode(Event.self, from: data) {
                return Result.success(event)
            } else {
                return Result.failure(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Could not decode data")))
            }
        } catch {
            return Result.failure(error)
        }
    }

    public func getEventsFor(user: User) async -> Result<[Event], Error> {
        return Result.success([Event()])
    }

    public func getFeedEventsFor(user: User) async -> Result<[Event], Error>{
        return Result.success([Event()])
    }
    
    public func removeUserEvent(user: User, event: Event) async -> Result<Event, Error>{
        return Result.success(Event())
    }
}

