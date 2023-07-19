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
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            
            TextField("Note", text: $note, axis: .vertical)

            Picker("Category", selection: $selectedCategory) {
                ForEach(dataStore.categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedCategory) { newValue in
                dataStore.updateCategory(bucketItem: bucketItem, category: newValue)
            }
        }
        .onAppear {
            note = bucketItem.note
            selectedCategory = bucketItem.category
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    dataStore.updateCategory(bucketItem: bucketItem, , note: note, category: selectedCategory)
                    dismiss()
                }
                .buttonStyle(.bordered)
                .disabled(selectedCategory.isEmpty)
            }
        }
        .navigationTitle(bucketItem.name)
    }
}





