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
            ForEach(days, id: \.self) { item in
                
                List(storeData.restaurantList) { laugh in
                        
                        //                if !storeData.restaurantList.isEmpty {
                        
                        Text(item)
                            .bold()
                            .font(.title)
                        Text(laugh.name)
                            .font(.title3)
                    
                }
//                } else {
//                    Text("Add your first Entre Item")
                
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
