//
//  Users.swift
//  inewshub
//
//  Created by seevsk on 3/11/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    var username: String
    var name: String
    var lastname: String
    var email: String
    let avatar_url: String?
    var role: String
    let is_active: Int
    let created_at: String?
    let updated_at: String?
}
