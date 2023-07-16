//
//  Hungry_App.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/18/23.
//

import SwiftUI
import WishKit

@main

struct Hungry_App: App {
    init() {
        WishKit.configure(with: "48F301E6-9B7D-46C5-90A4-401F19643817")
    }
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
