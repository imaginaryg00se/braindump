//
//  ContentView.swift
//  braindump
//
//  Created by William Huang on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    
    func saveNotes() {
        if let data = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(data, forKey: "notes")
        }
    }
    
    func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: "notes"),
           let savedNotes = try? JSONDecoder().decode([String].self, from: data) {
            notes = savedNotes
        }
    }

    @State private var notes: [String] = []
    @State private var newNote: String = ""
    
    var body: some View {
        VStack {
            Text("brain dump")
                .font(.largeTitle)
                .padding()

            TextField("Enter a note...", text: $newNote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add") {
                if !newNote.trimmingCharacters(in: .whitespaces).isEmpty {
                    notes.insert(newNote, at: 0)
                    newNote = ""
                    saveNotes()
                }
            }
            .padding()
            .disabled(newNote.trimmingCharacters(in: .whitespaces).isEmpty)

            List {
                ForEach(notes, id: \.self) { note in
                    Text(note)
                }
                .onDelete { indexSet in
                        notes.remove(atOffsets: indexSet)
                        saveNotes()
                    }
            }
            .onAppear {
                loadNotes()
            }
        }
    }
}

#Preview {
    ContentView()
}
