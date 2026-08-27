//
//  Articles.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: Int
    let title: String
    let excerpt: String
    let slug: String
    let content_type: String
    let hero_image: String?
    let is_story: Int
    let author_id: Int?
    let published_at: String

    // Only present on the detail endpoint (GET /articles/{slug})
    let body: String?
    let updated_at: String?
    let images: [ArticleImage]?

    var idString: String { String(id) }
}

struct ArticleImage: Codable {
    let image_url: String
    let sort_order: Int
}
