// RootView.swift
// Hungry?
// Created by Ed Kraus on 3/26/23.

import SwiftUI

struct RootView: View {
    // MARK: - Properties
    
    // State variable to keep track of the selected tab
    @State private var selectedTab: Tab = .home
    
    // Tab enum representing the different tabs in the TabView
    enum Tab {
        case home
        case explore
        case wishes
    }
    
    // MARK: - Body View
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // First Tab - Add Entre
            AddEntre()
                .tag(Tab.home) // Assign the "home" tag to this tab
            
            // Second Tab - WeeklyView
            WeeklyView()
                .tag(Tab.explore) // Assign the "explore" tag to this tab
            
            // Third Tab - WishListView
            WishListView()
                .tag(Tab.wishes) // Assign the "wishes" tag to this tab
        }
        .overlay(
            HStack(spacing: 0) {
                // Custom tab bar items using the tabBarItem function
                tabBarItem(tab: .home, imageName: "house") // Home tab with house icon
                tabBarItem(tab: .explore, imageName: "calendar") // Explore tab with calendar icon
                tabBarItem(tab: .wishes, imageName: "square.and.pencil.circle") // Wishes tab with pencil circle icon
            }
            .frame(height: 50) // Set the height of the custom tab bar
            .background(
                Capsule()
                    .fill(Color(.systemBackground)) // Use system background color for the tab bar
                    .shadow(radius: 4) // Add shadow to the tab bar
            )
            .padding(.horizontal, 16) // Add horizontal padding to the tab bar
            .padding(.bottom, 16) // Add bottom padding to the tab bar
            , alignment: .bottom // Align the custom tab bar to the bottom of the screen
        )
    }
    
    // MARK: - Helper ViewBuilder Function
    
    // Custom tab bar item using a Button with an image
    @ViewBuilder
    func tabBarItem(tab: Tab, imageName: String) -> some View {
        Button(action: {
            selectedTab = tab // Set the selected tab when the button is tapped
        }) {
            Image(systemName: imageName) // Display the SF Symbol image
                .resizable()
                .aspectRatio(contentMode: .fit) // Preserve aspect ratio of the image
                .frame(width: 20, height: 20) // Set a fixed size for the image
                .foregroundColor(tab == selectedTab ? .blue : .gray) // Set the image color based on the selected tab
        }
        .frame(maxWidth: .infinity) // Expand the button to fill the available width
    }
}

// MARK: - Preview

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView() // Preview the RootView
    }
}
