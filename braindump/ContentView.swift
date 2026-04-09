//
//  ContentView.swift
//  braindump
//
//  Created by William Huang on 4/8/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.createdAt, order: .reverse) private var notes: [Note]

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

                        let note = Note(text: trimmed)
                        modelContext.insert(note)
                        newNote = ""
                    }
                    .disabled(newNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()

                if notes.isEmpty {
                    ContentUnavailableView("No Notes Yet", systemImage: "note.text")
                        .padding(.top, 40)
                } else {
                    List {
                        ForEach(notes) { note in
                            NavigationLink {
                                EditNoteView(note: note)
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
                        .onDelete(perform: deleteNotes)
                    }
                }
            }
        }
    }

    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(notes[index])
        }
    }
}

#Preview {
    ContentView()
}
