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
    @FocusState private var nameIsFocused: Bool
    var body: some View {
        NavigationStack {
            VStack {
                HStack { TextField ("New Entre", text: $newEntre)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        storeData.create(newEntre)
                        newEntre = ""
                        nameIsFocused = false
                        
                    } label: {
                        Image (systemName: "plus.circle.fill")
                    }
                    .disabled (newEntre.isEmpty)
                    
                }.padding()
                if !storeData.restaurantList.isEmpty {
                    List {
                        ForEach($storeData.restaurantList) { $item in
                            NavigationLink(value: item) {
                                TextField(item.name, text: $item.name, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)

                            }
                            .onChange(of: item, perform: { _ in
                                storeData.saveList()
                            })
                            .listRowSeparator(.hidden)
                        }
                        .onDelete { indexSet in
                            storeData.delete(indexSet: indexSet)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text("Add your first Entre Item")
                    Image("bucketList") // No item in list
                    Spacer()
                }
            }
                .navigationTitle("Meal List")
            
                .navigationDestination(for: RestaurantItem .self) { item in
                    EditRestaurant(bucketItem: item)
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurant()
            .environmentObject(DataSource())
    }
}
