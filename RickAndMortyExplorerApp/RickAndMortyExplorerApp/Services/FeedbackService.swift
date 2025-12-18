import Foundation


struct FeedbackPayload: Codable {
    struct Record: Codable {
        struct Fields: Codable {
            let userName: String
            let notes: Int
            let message: String
            let appName: String
        }

        let fields: Fields
    }

    let records: [Record]
}


final class FeedbackService {

    static let shared = FeedbackService()
    private init() {}

    private let url = URL(string: "https://api.airtable.com/v0/appsN9SSKnWVnqwwQ/Formulaire")!

    private var apiToken: String {
        guard let token = ProcessInfo.processInfo.environment["AIRTABLE_TOKEN"],
              !token.isEmpty else {
            fatalError("AIRTABLE_TOKEN manquant. Vérifie les variables d’environnement.")
        }
        return token
    }


    func sendFeedback(
        userName: String,
        notes: Int,
        message: String
    ) async throws {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = FeedbackPayload(
            records: [
                FeedbackPayload.Record(
                    fields: .init(
                        userName: userName,
                        notes: notes,
                        message: message,
                        appName: "Rick & Morty Explorer"
                    )
                )
            ]
        )

        request.httpBody = try JSONEncoder().encode(payload)

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
}

