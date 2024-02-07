//
//  EventManager.swift
//  AppWithNastenka
//
//  Created by Ilyas Kudaibergenov on 10.11.2023.
//

import Foundation
import State
import AuthManager

public class EventManager {
    public func newEvent(place: String, eventName: String, eventDescription: String, characteristics: [(name: String, description: String)], participants: [User]) {
        
        let parameters: [String: Any] = [
            "place": place,
            "eventName": eventName,
            "eventDescription": eventDescription,
            "characteristics": characteristics.map { ["name": $0.name, "description": $0.description] },
            "participants": participants.map { ["id": $0.id, "email": $0.email, "username": $0.username] }
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Could not convert parameters to JSON")
            return
        }

        guard let url = URL(string: "\(APIConstants.baseURL)/newEvent") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                print("Response: \(json)")
            }
        }

        task.resume()
    }
}

