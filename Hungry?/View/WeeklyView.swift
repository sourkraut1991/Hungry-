//
//  WeeklyView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/25/23.
//

import SwiftUI

struct WeeklyView: View {
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @State private var meals: [(String, String)] = []
    @EnvironmentObject var storeData: DataSource
    
    var body: some View {
        VStack {
            VStack {
                Text("Pull down to refresh list")
                    .font(.caption)
                    .foregroundColor(.white)
                
                List(meals, id: \.0) { (day, entree) in
                    VStack(alignment: .leading) {
                        Text(day)
                            .bold()
                            .font(.title2)
                        Text(entree)
                            .font(.caption)
                    }
                }
                .refreshable {
                    shuffleMeals()
                    print("shuffling...")
                }
            }
            
            Button(action: {
                saveMeals()
            }) {
                Text("Save Meals")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            loadMeals()
        }
    }
       
        
    
    
    
    func loadMeals() {
        let fileURL = URL.documentsDirectory.appendingPathComponent("meals.json")
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let loadedMeals = try JSONDecoder().decode([RestaurantItem].self, from: jsonData)
            
            meals = loadedMeals.map { meal in
                (days.randomElement() ?? "", meal.name)
            }
            
            print("Meals loaded successfully!")
        } catch {
            print("Failed to load meals:", error.localizedDescription)
        }
    }
    
    
    
    func saveMeals() {
        let updatedRestaurantList: [RestaurantItem] = meals.map { meal in
            let newItem = RestaurantItem(name: meal.1)
            return newItem
        }
        
        let fileURL = URL.documentsDirectory.appendingPathComponent("meals.json")
        
        do {
            let jsonData = try JSONEncoder().encode(updatedRestaurantList)
            try jsonData.write(to: fileURL)
            print("Meals saved successfully!")
        } catch {
            print("Failed to save meals:", error.localizedDescription)
        }
    }
    func shuffleMeals() {
        let restaurantNames = storeData.restaurantList.map { $0.name }
        let shuffledNames = restaurantNames.shuffled()
        meals = Array(zip(days, shuffledNames))
    }
}


struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
            .environmentObject(DataSource())
    }
}
