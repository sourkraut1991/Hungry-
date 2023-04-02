//
//  WeeklyView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/25/23.
//

import SwiftUI

struct WeeklyView: View {
    
    @EnvironmentObject var storeData: DataSource
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  
    var body: some View {
        
        VStack {
//            if !storeData.restaurantList.isEmpty {
            
            List(Array(zip(days, storeData.restaurantList)), id: \.self) { (days, entre) in
                Text(days)
                    .bold()
                    .font(.title)
                Text(entre.name)
                    .font(.title3)
                
           
//                    } else {
//                        Text("Add your first Entre Item")
//                    }
            }
                .listStyle(.grouped)
        }  // If Empty
    }// End of Body
} // End of Struct





struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
