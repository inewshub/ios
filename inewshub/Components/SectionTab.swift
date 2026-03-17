//
//  SectionTab.swift
//  inewshub
//
//  Created by seevsk on 12/10/25.
//

import SwiftUI



struct SectionTab: View {
    let title: String
    let index: Int
    @Binding var selected: Int
    var animation: Namespace.ID

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .fixedSize(horizontal: true, vertical: false)
                .lineLimit(1)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: WidthKey.self, value: geo.size.width)
                    }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selected = index
                    }
                }

            if selected == index {
                Rectangle()
                    .fill(Color.black)
                    .matchedGeometryEffect(id: "underline", in: animation)
                    .frame(height: 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(width: underlineWidth)
                    .transition(.opacity)
            }
        }
        .onPreferenceChange(WidthKey.self) { width in
            underlineWidth = width * 0.7
        }
    }

    @State private var underlineWidth: CGFloat = 0
}


private struct WidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


