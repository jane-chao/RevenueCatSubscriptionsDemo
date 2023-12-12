//
//  RevenueCatSubscriptionDemoApp.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/11.
//

import SwiftUI

@main
struct RevenueCatSubscriptionDemoApp: App {
    @State var premiumSubscriptionInfo: SubscriptionInfo?
    
    var body: some Scene {
        WindowGroup {
            if let premiumSubscriptionInfo {
                HomeScreen(subscriptionInfo: premiumSubscriptionInfo,
                           onPurchase: { self.premiumSubscriptionInfo = .stubWithAccess })
            } else {
                ProgressView()
                    .task {
                        do {
                            premiumSubscriptionInfo = try await getPremiumSubscriptionInfo()
                        } catch {
                            Logger.iapService.error("Error on retrieving subscription info: \(error, privacy: .public)")
                        }
                    }
            }
        }
    }
}

private extension RevenueCatSubscriptionDemoApp {
    // 假裝 loading 取得訂閱資料
    func getPremiumSubscriptionInfo() async throws -> SubscriptionInfo {
        try await Task.sleep(for: .seconds(2))
        return .stubNoAccess
    }
}
