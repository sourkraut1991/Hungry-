//
//  EditRestaurant.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/24/23.
//

import SwiftUI

struct EditEntre: View {
    @EnvironmentObject var dataStore: DataSource
    let bucketItem: EntreItem
    @State private var note = ""
    @State private var selectedCategory = ""

    var body: some View {
        Form {
            TextField("Note", text: $note, axis: .vertical)
                .lineLimit(3, reservesSpace: true)
            TextField("Category", text: $selectedCategory).disabled(true)

        }
        .onAppear {
            note = bucketItem.note
            selectedCategory = bucketItem.category
        }
       

        .toolbar {
            ToolbarItem {
                Button("Update") {
                    dataStore.update(bucketItem: bucketItem, note: note, category: selectedCategory)
                }
                .buttonStyle(.bordered)
                .disabled(selectedCategory.isEmpty)
            }
        }
        .navigationTitle(bucketItem.name)
    }
}
