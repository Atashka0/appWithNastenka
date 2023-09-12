import Foundation

/// Ходит в сеть за юзером
public class AuthManager {
    public init() {}
    
    public func fetchUser(with email: String) async -> Result<String?, Error> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...500))")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode(Pokemon.self, from: data)
            return Result.success(decodedData?.name)
        } catch {
            return Result.failure(error)
        }
    }
    
    public func logOut() async -> Result<Int, Error> {
        // Интеджер в случае успеха отображает код состояния HTTP: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
        return Result.success(200)
    }
}

private struct Pokemon: Codable {
    let name: String
}
