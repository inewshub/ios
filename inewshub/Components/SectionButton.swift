//
//  SectionButton.swift
//  inewshub
//
//  Created by Alumno on 13/10/25.
//

import SwiftUI

struct SectionButton: View {
    let title: String
    let index: Int
    @Binding var selected: Int
    
    var body: some View {
        Button(action: { selected = index }) {
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(Color(.white))
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .background(Color("bg-color"))
                .cornerRadius(10)
        }
    }
}

