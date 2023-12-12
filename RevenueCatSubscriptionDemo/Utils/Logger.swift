//
//  Logger.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/10.
//

import os

enum Logger {
    static let iapService = os.Logger(subsystem: "com.chaocode.RevenueCatSubscriptionDemo", category: "IAP Service")
}
