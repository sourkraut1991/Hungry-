//
//  EditRestaurant.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/24/23.
//

import SwiftUI

struct EditRestaurant: View {
    @EnvironmentObject var dataStore: DataSource
    let bucketItem: RestaurantItem
    @State private var note = ""
    @State private var selectedCategory = ""

    var body: some View {
        Form {
            TextField("Note", text: $note)
            TextField("Category", text: $selectedCategory).disabled(true)
//            Picker("Category", selection: $selectedCategory) {
//                ForEach(dataStore.categories, id: \.self) { category in
//                    Text(category)
//                }
//            }
//            .pickerStyle(.menu)
//            .onChange(of: selectedCategory) { newValue in
//                dataStore.update(bucketItem: bucketItem, note: note, category: selectedCategory)
//            }
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
