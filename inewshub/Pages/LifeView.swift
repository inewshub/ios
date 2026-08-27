//
//  LifeView.swift
//  inewshub
//
//  Created by Alumno on 13/10/25.
//



import SwiftUI

struct LifeView: View {
    @State private var selectedSection = 2
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                SectionButton(title: "Facilities", index: 0, selected: $selectedSection)
                SectionButton(title: "Seminars", index: 1, selected: $selectedSection)
                SectionButton(title: "Societies", index: 2, selected: $selectedSection)
                SectionButton(title: "Green", index: 3, selected: $selectedSection)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            TabView(selection: $selectedSection) {
                FacilitiesView().tag(0)
                SeminarsView().tag(1)
                SocietiesView().tag(2)
                GreenView().tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}




#Preview {
    LifeView()
}
