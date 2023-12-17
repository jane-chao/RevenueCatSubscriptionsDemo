//
//  RevenueCatSubscriptionDemoApp.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/11.
//

import SwiftUI

@main
struct RevenueCatSubscriptionDemoApp: App {
    let iapService: IAPService
    @State var premiumSubscriptionInfo: SubscriptionInfo?

    init() {
        RevenueCatService.configOnLaunch()
        iapService = RevenueCatService()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                if let premiumSubscriptionInfo {
                    HomeScreen(subscriptionInfo: premiumSubscriptionInfo)
                } else {
                    ProgressView()
                }
            }
            .task {
                do {
                    try await iapService.monitoringSubscriptionInfoUpdates {
                        premiumSubscriptionInfo = $0
                    }
                } catch {
                    Logger.iapService.error("Error on handling customer info updates: \(error, privacy: .public)")
                }
            }
        }
    }
}
