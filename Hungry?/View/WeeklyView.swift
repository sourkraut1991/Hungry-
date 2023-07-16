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
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("Pull down to refresh list").font(.caption).foregroundColor(.white)
                
                List(meals, id: \.0) { (day, entree) in
                    
                    //\.0 refers to the first element in the tuple, i.e., the day
                    VStack(alignment: .leading) {
                        Text(day).bold().font(.title2)
                        Text(entree).font(.caption)
                    }
                }
                .refreshable {
                    shuffleMeals()
                    print("shuffling...")
                }
            }
        }
        .onAppear {
            shuffleMeals()
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
