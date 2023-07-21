//
//  testView.swift
//  Hungry?
//
//  Created by Ed Kraus on 4/22/23.
//

import SwiftUI

struct testView: View {
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
   
    @State private var meals: [(String, String)] = []
    @EnvironmentObject var storeData: DataSource
    var body: some View {
        VStack {
            Text("Pull down to refresh list").font(.caption)
            List(meals, id: \.0) { (day, entree) in
            //\.0 refers to the first element in the tuple, i.e., the day
                Section {
                        Text(entree)
                    Text(day)
                    }
  
            }
            .refreshable {
                shuffleMeals()
            }
        }
        .onAppear {
            shuffleMeals()
        }
    }
    
    func shuffleMeals() {
        let restaurantNames = storeData.entreList.map { $0.name }
        let shuffledNames = restaurantNames.shuffled()
        meals = Array(zip(days, shuffledNames))
    }

}


struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
            .environmentObject(DataSource())
    }
}
