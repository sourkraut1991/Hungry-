//
//  DataStore.swift
//  Bucket List
//
//  Created by Ed Kraus on 3/13/23.
//

import Foundation

struct RestaurantItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var note = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case note
    }
    
    
    static var samples: [RestaurantItem] {
        [
            RestaurantItem.init(name: "Climb Mount Everest"),
            RestaurantItem.init(name: "Visit Alaska", note: "Go to Anchorage"),
            RestaurantItem.init(name: "Get Married", note: "Already Married")
        ]
        
    }
}

class DataSource: ObservableObject {
    
    @Published var restaurantList: [RestaurantItem] = []
    // Helps create a json file to safe onto device
    let fileURL = URL.documentsDirectory.appending(path: "bucketList.json")
    
    init() {
        loadItems()
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
    func update(bucketItem: RestaurantItem, note: String) {
        if let index = restaurantList.firstIndex(where: {$0.id == bucketItem.id}) {
            restaurantList[index].note = note
            
            saveList()
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
    func create(_ newItem: String) {
        let newBucketItem = RestaurantItem(name: newItem)
        restaurantList.append(newBucketItem)
        saveList()
    }
    func delete(indexSet: IndexSet) {
        restaurantList.remove(atOffsets: indexSet)
        saveList()
    }
}


//12:15 stopping point; need to sleep
