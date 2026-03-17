//
//  AddNewsLocalView.swift
//  inewshub
//
//  Created by seevsk on 14/12/25.
//

import SwiftUI
import SwiftData

struct AddNewsLocalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var category: String = ""
    @State private var isFavorite: Bool = true

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("News information")) {
                    TextField("Title", text: $title)
                    TextField("Category", text: $category)
                    Toggle("Favorite", isOn: $isFavorite)
                }
            }
            .navigationTitle("Add News")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNews()
                    }
                    .disabled(title.isEmpty || category.isEmpty)
                }
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func saveNews() {
        let newNews = NewsLocal(
            id: Int(Date().timeIntervalSince1970), 
            title: title,
            category: category,
            isFavorite: isFavorite
        )

        modelContext.insert(newNews)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            alertMessage = "Error saving news"
            showAlert = true
        }
    }
}
