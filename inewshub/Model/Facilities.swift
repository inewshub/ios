//
//  Facilities.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import Foundation

struct Facility: Codable, Identifiable {
    let id: Int
    let subsection_id: Int
    let name: String
    let description: String?
    let image_url: String?
    let latitude: Double?
    let longitude: Double?
    let sort_order: Int
    let stars: Int
    
    var idFacility: Int { id }

    enum CodingKeys: String, CodingKey {
        case id
        case subsection_id
        case name
        case description
        case image_url
        case latitude = "latitude"
        case longitude = "longitude"
        case sort_order
        case stars
    }
}
