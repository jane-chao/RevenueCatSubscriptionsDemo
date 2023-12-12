//
//  MyPaywallScreen.swift
//  RevenueCatSubscriptionDemo
//
//  Created by Jane Chao on 2023/12/6.
//

import SwiftUI

struct MyPaywallScreen: View {
    let isEligibleForTrial: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("解開完整功能")
                    .font(.largeTitle.bold())
                    .kerning(3)
                    .padding(.top, 12)
                
                Image(.iceCreamHero)
                    .resizable()
                    .scaledToFit()
                
                SubTitleText(label: "您將享有：")
                
                VStack(alignment: .leading, spacing: 12) {
                    FeatureTextView(label: "季節限定口味")
                    FeatureTextView(label: "客製配料選項")
                    FeatureTextView(label: "優先配送")
                    FeatureTextView(label: "冰淇淋愛好者社群")
                }
                .frame(maxWidth: .infinity)
                
                Divider().padding(.top)
                
                SubTitleText(label: "看看其他人怎麼說：")
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(Review.stubReviews, content: ReviewCellView.init)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Divider().padding(.top)
                
                if isEligibleForTrial == true {
                    SubTitleText(label: "還不確定嗎？")
                    Group {
                        Text("不用擔心！試用期間 \(Text("完全免費、可隨時取消").bold().foregroundColor(.blue))，我們也會在三天前通知您試用即將到期 😉")
                            .font(.title3.weight(.medium)) + Text("（需開啟通知權限）")
                    }
                    .lineSpacing(12)
                    .padding(.horizontal, 24)
                }
                
                Spacer().frame(height: 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}

private struct SubTitleText: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.title2.weight(.medium))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.init(top: 12, leading: 24, bottom: 9, trailing: 24))
    }
}

private struct FeatureTextView: View {
    let label: String
    
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: "checkmark")
                .imageScale(.large)
                .foregroundStyle(.green)
            Text(label)
        }
        .font(.title2.bold())
        .padding(.horizontal)
    }
}

private struct ReviewCellView: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text(review.username)
                    .fontWeight(.medium)
                
                Text(review.date.formatted(.relative(presentation: .named).locale(.init(identifier: "zh-tw"))))
                    .font(.body)
            }
            HStack(spacing: 3) {
                ForEach(0..<review.stars, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .symbolRenderingMode(.multicolor)
                }
            }
            Text(review.review)
                .fontWeight(.medium)
        }
        .font(.title3)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground), in: .rect(cornerRadius: 6))
    }
}

private struct Review: Identifiable {
    var id: UUID = .init()
    let username: String
    let stars: Int
    let date: Date
    let review: String
    
    
    static var stubReviews: [Review] = [
        .init(username: "子晴", stars: 5,
              date: Date.now.addingTimeInterval(.day * -3),
              review: "真的很客製化，口味多且都可以調份量，低糖選項太幸福了 😍"),
        .init(username: "柏翰爸", stars: 5, 
              date: Date.now.addingTimeInterval(.day * -6),
              review: "沒有什麼是一桶冰淇淋不能解決的。"),
        .init(username: "Amy Chen", stars: 5, 
              date: Date.now.addingTimeInterval(.day * -12),
              review: "一開始覺得訂閱冰淇淋很荒謬，但訂下去就回不來了🤣🤣 那個恰到好處的柔軟口感～～～🫦🫦🤤"),
        .init(username: "王建宏", stars: 4, 
              date: Date.now.addingTimeInterval(.day * -12),
              review: "萬聖節口味超讚，希望有更多季節限定口味"),
        .init(username: "海岸", stars: 4, 
              date: Date.now.addingTimeInterval(.day * -30),
              review: "看冰淇淋狂熱者的討論很有趣，希望舉辦聚會XD"),
    ]
}

#if DEBUG
struct MyPaywallScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyPaywallScreen(isEligibleForTrial: true)
    }
}
#endif
