//
//  UserScreen.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/6.
//

import SwiftUI

struct UserScreen: View {
    let subscriptionState: SubscriptionState
    
    var body: some View {
        VStack(spacing: 12) {
            Image(.catProfile)
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
                .padding(.horizontal, 42)
            
            Text("Jane")
                .font(.title.bold())
            
            Text(subscriptionState.description)
                .font(.title3.bold())
        }
    }
}

#if DEBUG
struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserScreen(subscriptionState: .notSubscribed)
    }
}
#endif
