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
                saveMeals(to: URL.documentsDirectory.appendingPathComponent("customMeals.json"))
            }) {
                Text("Save Meals")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top) // Add some top padding to separate the button from the list
        }
        .onAppear {
            loadMeals()
        }
    }
    
    
    func loadMeals() {
        let fileURL = URL.documentsDirectory.appendingPathComponent("customMeals.json")
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let loadedMeals = try JSONDecoder().decode([EntreItem].self, from: jsonData)
            
            meals = loadedMeals.enumerated().map { (index, meal) in
                let dayIndex = index % days.count
                return (days[dayIndex], meal.name)
            }
            
            print("Meals loaded successfully!")
        } catch {
            print("Failed to load meals:", error.localizedDescription)
        }
    }
    
    func saveMeals(to fileURL: URL) {
        let updatedMeals: [EntreItem] = meals.map { meal in
            if let existingMeal = storeData.entreList.first(where: { $0.name == meal.1 }) {
                // If the meal already exists in the storeData, use the existing item
                return existingMeal
            } else {
                // Otherwise, create a new EntreItem
                let newItem = EntreItem(name: meal.1)
                return newItem
            }
        }
        
        do {
            let jsonData = try JSONEncoder().encode(updatedMeals)
            try jsonData.write(to: fileURL)
            print("Meals saved successfully!")
        } catch {
            print("Failed to save meals:", error.localizedDescription)
        }
    }
    
    func shuffleMeals() {
        let restaurantNames = storeData.entreList.map { $0.name }
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
