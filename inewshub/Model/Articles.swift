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
    let body: String
    let content_type: String
    let is_story: Int
    let hero_image: String
    let author_id: Int?
    let is_published: Int
    let is_active: Int
    let published_at: String      
    let updated_at: String

    var idString: String { String(id) } 
}
