//
//  StartButton.swift
//  inewshub
//
//  Created by seevsk on 1/10/25.
//

import SwiftUI

struct StartButton: View {
    let title: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22.5))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 320, height: 60)
                .background(Color("bg-color"))
                .cornerRadius(13)
        }
    }
}

