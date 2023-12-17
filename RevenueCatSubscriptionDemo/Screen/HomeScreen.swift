//
//  HomeScreen.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/1.
//

import SwiftUI

struct HomeScreen: View {
    let subscriptionInfo: SubscriptionInfo
    
    var body: some View {
        if subscriptionInfo.canAccessContent {
            UserScreen(subscriptionState: subscriptionInfo.subscriptionState)
        } else {
            MyPaywallScreen(isEligibleForTrial: subscriptionInfo.isEligibleForTrial)
        }
    }
}


#if DEBUG
struct HomeScreen_Previews: PreviewProvider, View {
    @State var premiumSubscriptionInfo: SubscriptionInfo = .stubNoAccess
    
    var body: some View {
        HomeScreen(subscriptionInfo: premiumSubscriptionInfo)
    }
    
    static var previews: some View {
        Self()
    }
}
#endif
