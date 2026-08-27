//
//  Facilities.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import Foundation

struct Facility: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
    let image_url: String?
    let stars: Int?
    let price_min: String?
    let price_max: String?
    let currency: String?

    // Only present on the detail endpoint (GET /facilities/{slug})
    let description: String?
    let open_time: String?
    let close_time: String?
    let latitude: Double?
    let longitude: Double?
    let country: String?
    let region: String?
    let province: String?
    let district: String?
    let address: String?
}
