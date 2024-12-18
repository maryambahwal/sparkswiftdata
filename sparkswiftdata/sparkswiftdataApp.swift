//
//  sparkswiftdataApp.swift
//  sparkswiftdata
//
//  Created by Maryam Bahwal on 16/06/1446 AH.
//

import SwiftUI
import SwiftData

@main
struct sparkswiftdataApp: App {
    var body: some Scene {
        WindowGroup {
            GhadaView()
//            TaskList()
        }
        .modelContainer(for: Task.self)
    }
}
