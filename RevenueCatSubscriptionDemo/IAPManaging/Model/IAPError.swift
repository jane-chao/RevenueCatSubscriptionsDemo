//
//  IAPError.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/10.
//

import Foundation

enum IAPError: Error {
    case verificationFailed
    case noAvailableStoreProduct
    case missingEntitlement
}
