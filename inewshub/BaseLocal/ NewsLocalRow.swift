//
//   NewsLocalRow.swift
//  inewshub
//
//  Created by seevsk on 14/12/25.
//

import Foundation
import SwiftUI
import SwiftData

struct NewsLocalRow: View {
    @Bindable var news: NewsLocal
    @Environment(\.editMode) private var editMode

    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }

    var body: some View {
        HStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 6) {

                HStack {
                    Text("Title:")
                        .fontWeight(.semibold)

                    TextField("Title", text: $news.title)
                        .disabled(!isEditing)
                }

                HStack {
                    Text("Category:")
                        .fontWeight(.semibold)

                    TextField("Category", text: $news.category)
                        .disabled(!isEditing)
                }

                Text(formattedDate(news.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if news.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .padding(.top, 4)
            }
        }
        .padding(.vertical, 6)
        .opacity(isEditing ? 1.0 : 0.9)
    }

    private func formattedDate(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
}
