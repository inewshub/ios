//
//  FavoritesView.swift
//  inewshub
//
//  Created by seevsk on 14/12/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode

    @Query(sort: \NewsLocal.date, order: .reverse)
    private var news: [NewsLocal]

    @State private var showAdd = false

    var body: some View {
        ZStack {

            NavigationStack {
                List {
                    if news.isEmpty {
                        ContentUnavailableView(
                            "No local news",
                            systemImage: "star",
                            description: Text("Add a news item")
                        )
                    } else {
                        ForEach(news) { item in
                            NewsLocalRow(news: item)
                        }
                        .onDelete(perform: delete)
                    }
                }
                .navigationTitle("Local News")
                .background(Color.white)
                .scrollContentBackground(.hidden)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()

                    VStack(spacing: 14) {

                   
                        Button {
                            showAdd = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 6)
                        }

                  
                        Button {
                            toggleEdit()
                        } label: {
                            Image(systemName:
                                editMode?.wrappedValue == .active
                                ? "checkmark"
                                : "pencil"
                            )
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.green)
                            .clipShape(Circle())
                            .shadow(radius: 6)
                        }
                    }
                    .padding()
                    
                }
            }
        }
        .sheet(isPresented: $showAdd) {
            AddNewsLocalView()
        }
    }


    private func toggleEdit() {
        withAnimation {
            editMode?.wrappedValue =
                editMode?.wrappedValue == .active ? .inactive : .active
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(news[index])
        }
        try? modelContext.save()
    }
}
