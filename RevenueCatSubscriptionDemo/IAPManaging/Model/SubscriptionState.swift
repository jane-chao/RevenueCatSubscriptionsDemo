//
//  SubscriptionState.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/6.
//

import Foundation

enum SubscriptionState {
    case notSubscribed
    case inTrial(endDate: Date)
    case subscribed(endDate: Date)
}

extension SubscriptionState: CustomStringConvertible {
    public var description: String {
        switch self {
            case .notSubscribed: "未訂閱"
            case let .inTrial(endDate): "試用期至 \(endDate.formatted(date: .abbreviated, time: .shortened))"
            case let .subscribed(endDate): "訂閱至 \(endDate.formatted(date: .abbreviated, time: .shortened))"
        }
    }
}
