//
//  Hungry_App.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/18/23.
//

import SwiftUI

@main
struct Hungry_App: App {
    @StateObject var dataSource = DataSource()
    var body: some Scene {
      
        WindowGroup {
            RootView()
                .environmentObject(dataSource)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
