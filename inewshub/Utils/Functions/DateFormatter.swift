//
//  DateFormatter.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import Foundation

// MARK: - Funcion Formato de fecha
func formatDate(_ dateString: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let date = formatter.date(from: dateString) {
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date)
    } else {
        return dateString
    }
}
