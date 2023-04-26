//
//  OnboardingViews.swift
//  Hungry?
//
//  Created by Ed Kraus on 4/2/23.
//

import SwiftUI

struct OnboardingPageView: View {
    
    var body: some View {
        VStack {
            Text("Pull down to refresh list").font(.caption)
        }
    }
}

struct OnboardingViews_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
