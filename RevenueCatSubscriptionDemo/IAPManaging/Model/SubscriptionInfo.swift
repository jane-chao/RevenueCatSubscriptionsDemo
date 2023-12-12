//
//  SubscriptionInfo.swift
//  RevenueCatMontlySubDemo1
//
//  Created by Jane Chao on 2023/12/11.
//

import Foundation

struct SubscriptionInfo {
    var canAccessContent: Bool
    var isEligibleForTrial: Bool
    var subscriptionState: SubscriptionState
    
    init(canAccessContent: Bool, isEligibleForTrial: Bool, subscriptionState: SubscriptionState) {
        self.canAccessContent = canAccessContent
        self.isEligibleForTrial = isEligibleForTrial
        self.subscriptionState = subscriptionState
    }
}

// Preview Stub
extension SubscriptionInfo {
    static var stubNoAccess: SubscriptionInfo {
        SubscriptionInfo(canAccessContent: false, isEligibleForTrial: true, subscriptionState: .notSubscribed)
    }
    static var stubWithAccess: SubscriptionInfo {
        SubscriptionInfo(canAccessContent: true, isEligibleForTrial: false, subscriptionState: .subscribed(endDate: .now + .day * 7))
    }
}
