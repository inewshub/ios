//
//  APIResponse.swift
//  inewshub
//

import Foundation

// Standard envelope returned by every endpoint: { "success", "message", "data" }
struct APIResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let data: T
}

// Shape of `data` for list endpoints (GET /articles, GET /facilities, etc.)
struct ItemsPayload<T: Decodable>: Decodable {
    let items: [T]
}
