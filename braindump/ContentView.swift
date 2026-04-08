//
//  ContentView.swift
//  braindump
//
//  Created by William Huang on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var newNote: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Quick Notes")
                    .font(.largeTitle)
                    .padding(.top)

                HStack {
                    TextField("Enter a note...", text: $newNote)
                        .textFieldStyle(.roundedBorder)

                    Button("Add") {
                        let trimmed = newNote.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }

                        let note = Note(
                            id: UUID(),
                            text: trimmed,
                            createdAt: Date()
                        )

                        notes.insert(note, at: 0)
                        newNote = ""
                        saveNotes()
                    }
                    .disabled(newNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()

                List {
                    ForEach($notes) { $note in
                        NavigationLink {
                            EditNoteView(note: $note, onSave: saveNotes)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.text)
                                    .lineLimit(1)

                                Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        notes.remove(atOffsets: indexSet)
                        saveNotes()
                    }
                }
            }
            .onAppear {
                loadNotes()
            }
        }
    }

    func saveNotes() {
        if let data = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(data, forKey: "notes")
        }
    }

    func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: "notes"),
           let savedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            notes = savedNotes
        }
    }
}

#Preview {
    ContentView()
}
