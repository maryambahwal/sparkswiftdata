//
//  ContentView.swift
//  Spark
//
//  Created by Maryam Bahwal on 09/06/1446 AH.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showCancelView = false
    var body: some View {
                    Text("Hello To Spark App")
    }
}

#Preview {
    ContentView()
}
