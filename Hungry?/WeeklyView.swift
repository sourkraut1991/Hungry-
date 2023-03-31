//
//  WeeklyView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/25/23.
//

import SwiftUI

struct WeeklyView: View {

    @EnvironmentObject var storeData: DataSource
    
    var body: some View {
        
        VStack{
            if !storeData.restaurantList.isEmpty {
                List {
                    if let random = storeData.restaurantList.randomElement() {
                        Section("Monday"){
                            Text(random.name)
                                .textFieldStyle(.roundedBorder)
                                .font(.title3)
                        }
                        
                        if let random2 = storeData.restaurantList.randomElement() {
                            Section("Tuesday"){
                                Text(random2.name)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                            }
                            
                            if let random3 = storeData.restaurantList.randomElement() {
                                Section("Wednesday"){
                                    Text(random3 .name)
                                        .textFieldStyle(.roundedBorder)
                                        .font(.title3)
                                }
                            }
                            
                        }
                    } else {
                        Text("Add your first Entre Item")
                        Spacer()
                    }
                }}
        }
    }
} // End of VStack





struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
