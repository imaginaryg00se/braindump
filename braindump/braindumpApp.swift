//
//  braindumpApp.swift
//  braindump
//
//  Created by William Huang on 4/8/26.
//

import SwiftUI
import SwiftData

@main
struct braindumpApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
