//
//  DataStore.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/13/23.
//

import Foundation

struct RestaurantItem: Codable, Hashable, Identifiable {
    var id = UUID()
    var name: String
    var note: String
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case note
        case category
    }
    
    init(id: UUID = UUID(), name: String, note: String = "", category: String = "") {
        self.id = id
        self.name = name
        self.note = note
        self.category = category
    }
}


class DataSource: ObservableObject {
    @Published var restaurantList: [RestaurantItem] = []
    @Published var categories: [String] = []
    // Helps create a json file to safe onto device
    let fileURL = URL.documentsDirectory.appending(path: "bucketList.json")
    
    init() {
        loadItems()
        
    }
    func addCategory(_ newCategory: String) {
            if !categories.contains(newCategory) {
                categories.append(newCategory)
            }
        }
    func updateCategory(bucketItem: RestaurantItem, category: String) {
         if let index = restaurantList.firstIndex(where: { $0.id == bucketItem.id }) {
             restaurantList[index].category = category
             saveList()
         }
     }
    func loadItems() {
        if FileManager().fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                restaurantList = try JSONDecoder().decode([RestaurantItem].self, from: data)
                
            } catch {
                // If file is corrupt so you currently the bucketlist is empty so store it and replace damaged file
                saveList()
            }
           
        }
        
    }
    
    func update(bucketItem: RestaurantItem, note: String, category: String) {
        if let index = restaurantList.firstIndex(where: { $0.id == bucketItem.id }) {
            restaurantList[index].note = note
            restaurantList[index].category = category
            saveList() // Add this line to save the updated data
        }
    }


    //TODO: go over episode 3 to annotate what each line does.
    func saveList() {
        do {
            let bucketListData = try JSONEncoder().encode(restaurantList)
            let bucketListString = String(decoding: bucketListData, as: UTF8.self)
            try bucketListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Could not encode bucket list and save it")
        }
    }
    func create(_ newItem: String, category: String) {
        let newRestaurantItem = RestaurantItem(name: newItem, category: category)
        restaurantList.append(newRestaurantItem)
        saveList()

        if !categories.contains(category) {
            categories.append(category)
        }
    }

    func delete(indexSet: IndexSet) {
        restaurantList.remove(atOffsets: indexSet)
        saveList()
    }
}
extension Bundle {
    
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
} // End Of Bundle Extension

