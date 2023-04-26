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
   
    @Environment(\.dismiss) var dismiss
   
    var body: some View {
        Form {
            TextField("note", text: $note, axis: .vertical)
           
        }
        .onAppear {
            note = bucketItem.note
           
            
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    dataStore.update(bucketItem: bucketItem, note: note)
                    
                        dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle(bucketItem.name)
    }
}


struct DetailView_Previews: PreviewProvider {
    static let bucketItem = RestaurantItem.samples[2]
    static let bucketList: Binding<[RestaurantItem]> = .constant(RestaurantItem.samples)
    static var previews: some View {
        NavigationStack {
            EditRestaurant(bucketItem: bucketItem).environmentObject(DataSource())
        }
    }
}
