//
//  OptionsView.swift
//  inewshub
//
//  Created by seevsk on 15/12/25.
//

import SwiftUI

struct OptionsView: View {

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                OptionRow(icon: "gearshape", title: "Settings")
                OptionRow(icon: "slider.horizontal.3", title: "Interests")
                OptionRow(icon: "bookmark", title: "Saved")
                OptionRow(icon: "doc.text", title: "References")
                OptionRow(icon: "arrow.backward.square", title: "Sign Out")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}


struct OptionRow: View {

    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 14) {

 
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 32, height: 32)

                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(.gray.opacity(0.6))
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .disabled(true)
    }
}


#Preview {
    OptionsView()
}
