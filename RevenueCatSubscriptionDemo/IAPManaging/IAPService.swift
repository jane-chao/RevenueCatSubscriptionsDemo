//
//  IAPService.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/15.
//

import Foundation

protocol IAPService {
    static func configOnLaunch()
    func monitoringSubscriptionInfoUpdates(updateHandler: @escaping (SubscriptionInfo) -> Void) async throws
}
