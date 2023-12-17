//
//  RevenueCatService.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/1.
//

import RevenueCat

final class RevenueCatService {
    private let service: Purchases
    private let didHandleInitialState: Bool
    private let entitlement: String
    
    init(service: Purchases = .shared,
         didHandleInitialState: Bool = false,
         entitlement: String = RCConstants.premium) {
        self.service = service
        self.didHandleInitialState = didHandleInitialState
        self.entitlement = entitlement
    }
}

extension RevenueCatService: IAPService {
    static func configOnLaunch() {
        Purchases.logLevel = .info
        Purchases.configure(with:
                .init(withAPIKey: RCConstants.apiKey)
                .with(usesStoreKit2IfAvailable: true)
                .with(entitlementVerificationMode: .informational)
        )
    }
    
    func monitoringSubscriptionInfoUpdates(updateHandler: @escaping (SubscriptionInfo) -> Void) async throws {
        for try await customerInfo in service.customerInfoStream {
            guard customerInfo.entitlements.verification.isVerified else {
                throw IAPError.verificationFailed
            }
            let subscriptionInfo = if !didHandleInitialState {
                try await getInitialSubscriptionInfo(from: customerInfo)
            } else {
                try getUpdatedSubscriptionInfo(from: customerInfo)
            }
            updateHandler(subscriptionInfo)
        }
    }
}

// MARK: - helper
private extension RevenueCatService {
    func getInitialSubscriptionInfo(from customerInfo: CustomerInfo) async throws -> SubscriptionInfo {
        guard let state = convertCustomerInfo(customerInfo) else {
            return .init(canAccessContent: false, isEligibleForTrial: try await checkTrialEligibility(), subscriptionState: .notSubscribed)
        }
        return state
    }
    
    func getUpdatedSubscriptionInfo(from customerInfo: CustomerInfo) throws -> SubscriptionInfo {
        guard let state = convertCustomerInfo(customerInfo) else {
            throw IAPError.missingEntitlement
        }
        return state
    }
    
    func convertCustomerInfo(_ customerInfo: CustomerInfo) -> SubscriptionInfo? {
        guard
            let entitlement = customerInfo.entitlements[entitlement],
            entitlement.isActive,
            let expirationDate = entitlement.expirationDate else {
            return nil
        }
        let state: SubscriptionState = switch entitlement.periodType {
        case .normal: .subscribed(endDate: expirationDate)
        case .intro, .trial: .inTrial(endDate: expirationDate)
        }
        
        return .init(canAccessContent: true, isEligibleForTrial: false, subscriptionState: state)
    }
    
    func checkTrialEligibility() async throws -> Bool {
        let offerings = try await service.offerings()
        guard let product = offerings.current?.availablePackages.first?.storeProduct else {
            throw IAPError.noAvailableStoreProduct
        }
        return (await service.checkTrialOrIntroDiscountEligibility(product: product)).isEligible
    }
}
