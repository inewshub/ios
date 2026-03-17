//
//  NewsLocal.swift
//  inewshub
//
//  Created by seevsk on 14/12/25.
//

import SwiftData
import Foundation

@Model
final class NewsLocal {
    var id: Int
    var title: String
    var category: String
    var date: Date
    var isFavorite: Bool

    init(
        id: Int,
        title: String,
        category: String,
        isFavorite: Bool = true,
        date: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.isFavorite = isFavorite
        self.date = date
    }
}

