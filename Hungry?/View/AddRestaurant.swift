//
//  ContentView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/18/23.
//

import SwiftUI

struct AddRestaurant: View {
    @EnvironmentObject var storeData: DataSource
    @State private var newEntre = ""
    @State private var selectedCategory = ""
    @State private var newCategory = ""
    @State private var nameIsFocused: Bool = false

    var filteredRestaurantList: [RestaurantItem] {
        if selectedCategory.isEmpty {
            return storeData.restaurantList
        } else {
            return storeData.restaurantList.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
               
                    HStack {
                        TextField("New Entre", text: $newEntre)
                            .textFieldStyle(.roundedBorder)
                        
                        Button {
                            storeData.create(newEntre, category: selectedCategory)
                            newEntre = ""
                            selectedCategory = ""
                            nameIsFocused = false
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newEntre.isEmpty || selectedCategory.isEmpty )
                    }
                

               
                    HStack {
                        TextField("New Category", text: $newCategory)
                            .textFieldStyle(.roundedBorder)
                        
                        Button {
                            storeData.addCategory(newCategory)
                            newCategory = ""
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newCategory.isEmpty)
                    }
                

                

                if !filteredRestaurantList.isEmpty {
                    Section(header: Text("Restaurant List")) {
                        Picker("Select Category", selection: $selectedCategory) {
                            Text("All").tag("")
                            ForEach(storeData.categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(.automatic)
                        List {
                            ForEach(filteredRestaurantList.indices, id: \.self) { index in
                                                        let item = filteredRestaurantList[index]
                                                        NavigationLink(destination: EditRestaurant(bucketItem: item)) {
                                                            TextField(item.name, text: $storeData.restaurantList[index].name, axis: .vertical)
                                                                .textFieldStyle(.roundedBorder)
                                                                .font(.title3)
                                                        }
                                                        .listRowSeparator(.hidden)
                            }
                            .onDelete { indexSet in
                                let indicesToRemove = IndexSet(indexSet.map { filteredRestaurantList.index(after: $0) })
                                storeData.delete(indexSet: indicesToRemove)
                            }
                        }
                    }
                } else {
                    Section {
                        Text("Add your first Entre Item")
                        Image("bucketList") // No item in list
                        Spacer()
                    }
                }
            }
            .navigationTitle("Meal List")
        }
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurant()
            .environmentObject(DataSource())
    }
}
