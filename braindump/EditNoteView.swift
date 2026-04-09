import SwiftUI
import SwiftData

struct EditNoteView: View {
    @Bindable var note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Edit Note")
                .font(.title)

            TextEditor(text: $note.text)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3))
                )
                .frame(minHeight: 200)

            Text("Created: \(note.createdAt.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
    }
}
