//
//  ContentView.swift
//  braindump
//
//  Created by William Huang on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("brain dump")
                .font(.largeTitle)
                .padding()

            TextField("Enter a note...", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add") {
                // do nothing for now
            }
            .padding()

            List {
                Text("Example note 1")
                Text("Example note 2")
            }
        }
    }
}

#Preview {
    ContentView()
}
