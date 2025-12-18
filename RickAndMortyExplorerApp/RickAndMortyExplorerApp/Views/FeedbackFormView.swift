import Foundation

import SwiftUI

struct FeedbackFormView: View {
    @State private var pseudo = ""
    @State private var message = ""
    @State private var note = 3
    @State private var isSending = false
    @State private var sendError: String?
    @State private var sendSuccess = false

    var isFormValid: Bool {
        !pseudo.trimmingCharacters(in: .whitespaces).isEmpty &&
        !message.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        Form {
            Section("Vos infos") {
                TextField("Pseudo", text: $pseudo)
                Stepper("Note : \(note)", value: $note, in: 1...5)
            }

            Section("Message") {
                TextEditor(text: $message)
                    .frame(minHeight: 120)
            }

            if let error = sendError {
                Text(error)
                    .foregroundColor(.red)
            }
            if sendSuccess {
                Text("Merci pour votre avis !")
                    .foregroundColor(.green)
            }

            Button {
                Task {
                    await send()
                }
            } label: {
                if isSending {
                    ProgressView()
                } else {
                    Text("Envoyer")
                }
            }
            .disabled(!isFormValid || isSending)
        }
        .navigationTitle("Suggestion / Avis")
    }

    private func send() async {
        isSending = true
        sendError = nil
        sendSuccess = false
        do {
            try await FeedbackService.shared.sendFeedback(
                userName: pseudo,
                notes: note,
                message: message
            )
            sendSuccess = true
        } catch {
            sendError = "Envoi échoué : \(error.localizedDescription)"
        }
        isSending = false
    }
}
