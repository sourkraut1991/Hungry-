//
//  RootView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/26/23.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab = 1
    var body: some View {
       

        TabView(selection: $selectedTab){
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    
                AddRestaurant()
            }
            .tabItem({
                Text("Add Restaurants")
                Image(systemName: "plus")
            })
            .tag(1)

            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                WeeklyView()
            }.tabItem({
                Text("Weekly View")
                Image(systemName: "calendar")
            })
            .tag(2)
            
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
