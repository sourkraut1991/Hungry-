//
//  RootView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/26/23.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case explore
        case wishes
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            AddRestaurant()
                .tag(Tab.home)
            WeeklyView()
                .tag(Tab.explore)
            WishListView()
                .tag(Tab.wishes)

        }
        .overlay(
            HStack(spacing: 0) {
                tabBarItem(tab: .home, imageName: "house")
                tabBarItem(tab: .explore, imageName: "calendar")
                tabBarItem(tab: .wishes, imageName: "square.and.pencil.circle")

            }
            .frame(height: 50)
            .background(
                Capsule()
                    .fill(Color(.systemBackground)) // Use system background color
                    .shadow(radius: 4)
            )

            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            , alignment: .bottom
        )
    }
    
    @ViewBuilder
    func tabBarItem(tab: Tab, imageName: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(tab == selectedTab ? .blue : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
