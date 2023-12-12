//
//  HomeScreen.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/1.
//

import SwiftUI

struct HomeScreen: View {
    let subscriptionInfo: SubscriptionInfo
    let onPurchase: () -> Void
    
    var body: some View {
        if subscriptionInfo.canAccessContent {
            UserScreen(subscriptionState: subscriptionInfo.subscriptionState)
        } else {
            VStack {
                Text("🔒 未解鎖 Premium 內容")
                Button("購買", action: onPurchase)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}


#if DEBUG
struct HomeScreen_Previews: PreviewProvider, View {
    @State var premiumSubscriptionInfo: SubscriptionInfo = .stubNoAccess
    
    var body: some View {
        HomeScreen(subscriptionInfo: premiumSubscriptionInfo) {
            premiumSubscriptionInfo = .stubWithAccess
        }
    }
    
    static var previews: some View {
        Self()
    }
}
#endif
