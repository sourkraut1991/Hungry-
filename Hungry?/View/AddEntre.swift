// AddRestaurant.swift
// Hungry?
// Created by Ed Kraus on 3/18/23.

import SwiftUI

struct AddEntre: View {
    // MARK: - Properties
    
    // Access the global data source object to manage entre data
    @EnvironmentObject var storeData: DataSource
    
    // State variables to hold user inputs
    @State private var newEntre = ""                // New entre item's name
    @State private var selectedCategory = ""        // Selected category for filtering
    @State private var newCategory = ""             // New category to be added
    @State private var nameIsFocused: Bool = false  // Check if the name field is focused
    @State private var isDropdownVisible = false    // Check if the category dropdown is visible
    @State private var isPresentingFormSheet = false // Check if the add form sheet is presented
    
    // A computed property to get the list of entres filtered by the selected category
    var filteredEntres: [EntreItem] {
        if selectedCategory.isEmpty {
            return storeData.entreList // Return all entres if no category is selected
        } else {
            return storeData.entreList.filter { $0.category == selectedCategory }
        }
    }
    
    // MARK: - Body View
    
    var body: some View {
        NavigationView {
            Form {
                // Check if the filtered entre list is not empty
                if !filteredEntres.isEmpty {
                    Section(header: Text("")) {
                        // Category Picker
                        Picker("Select Category", selection: $selectedCategory) {
                            Text("All").tag("") // Show "All" option to display all categories
                            ForEach(storeData.categories, id: \.self) { category in
                                Text(category).tag(category) // Display existing categories
                            }
                        }
                        .pickerStyle(.automatic)
                        
                        // List of Entres
                        List {
                            ForEach(filteredEntres.indices, id: \.self) { index in
                                let item = filteredEntres[index]
                                // Navigation link to edit entre details
                                NavigationLink(destination: EditEntre(bucketItem: item).environmentObject(storeData)) {
                                    Text(item.name) // Display entre name
                                }
                                .listRowSeparator(.hidden) // Hide list separators
                            }
                            // Handle entre deletion
                            .onDelete { indexSet in
                                storeData.delete(indexSet: indexSet)
                            }

                        }
                    }
                } else {
                    // Empty Entre List Section
                    Section {
                        Text("Add your first Entre Item") // Prompt to add the first item
                        Image("") // Display an image for an empty list (empty image name)
                        Spacer() // Add some space between elements
                    }
                }
            }
            .navigationTitle("Meal List") // Set the navigation title
            
            // Add a button to present the form sheet for adding a new entre
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingFormSheet = true // Set the flag to present the form sheet
                    }) {
                        Image(systemName: "plus") // Display a "+" icon
                    }
                }
            }
            .sheet(isPresented: $isPresentingFormSheet) {
                // Show the half sheet form here
                VStack(spacing: 16) {
                    TextField("New Entre", text: $newEntre) // Text field for entering new entre name
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    TextField("New Category", text: $newCategory) // Text field for entering new category
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    Button("Add") {
                        storeData.create(newEntre, category: newCategory) // Add new entre to the data source
                        newEntre = "" // Clear the new entre field
                        newCategory = "" // Clear the new category field
                        isPresentingFormSheet = false // Dismiss the form sheet
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: 60, minHeight: 30)
                    .background(Capsule().fill(Color.blue))
                    .disabled(newEntre.isEmpty || newCategory.isEmpty) // Disable the button if fields are empty
                }
                .padding()
                .presentationDetents([.fraction(0.25)]) // Set the height of the half sheet
            }
        }
    }
}

// MARK: - Preview

struct AddRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        AddEntre()
            .environmentObject(DataSource()) // Provide a preview data source for testing
    }
}
