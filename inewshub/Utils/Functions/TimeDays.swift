//
//  TimeDays.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import Foundation

// MARK: - Tiempo transcurrido
func timeAgo(from dateString: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    guard let date = formatter.date(from: dateString) else { return "Unknown" }
    
    let calendar = Calendar.current
    let now = Date()
    let components = calendar.dateComponents([.day, .hour, .minute], from: date, to: now)
    
    if let days = components.day, days > 0 {
        return days == 1 ? "1 day ago" : "\(days) days ago"
    } else if let hours = components.hour, hours > 0 {
        return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
    } else if let minutes = components.minute, minutes > 0 {
        return minutes == 1 ? "1 minute ago" : "\(minutes) minutes ago"
    } else {
        return "Just now"
    }
}
