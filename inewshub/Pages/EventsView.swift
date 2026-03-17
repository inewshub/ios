//
//  EventsView.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import SwiftUI

// MARK: - Data Manager para Events
class DataManagerEvents: ObservableObject {
    @Published var events: [Article] = []
    @Published var isLoading = false

    func fetchEvents() {
        guard let url = URL(string: "https://seevsk.alwaysdata.net/inewshub/articles/event.php") else {
            print("URL inválida")
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                print("Error de red:", error.localizedDescription)
                return
            }

            guard let data = data else {
                print("No se recibió data del servidor")
                return
            }

            do {
                // Decodificamos directamente artículos
                let decoded = try JSONDecoder().decode([Article].self, from: data)
                DispatchQueue.main.async {
                    self.events = decoded
                }
            } catch {
                print("Error al decodificar JSON:", error)
            }
        }.resume()
    }
}

// MARK: - Tarjeta individual de cada Event
struct EventCardView: View {
    let item: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // MARK: Imagen superior
            GeometryReader { geo in
                AsyncImage(url: URL(string: "https://seevsk.alwaysdata.net/inewshub/drawable/\(item.content_type)/\(item.hero_image)")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width / 2)
                            .foregroundColor(.gray.opacity(0.4))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .empty:
                        ZStack {
                            Color.gray.opacity(0.1)
                            ProgressView()
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(height: 120)
            .cornerRadius(10)

            // MARK: Título del Event
            Text(item.title)
                .font(.headline)
                .lineLimit(2)
                .foregroundColor(.primary)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity, alignment: .leading)

            // MARK: Fecha y enlace "Read more"
            HStack {
                Label(formatDate(item.published_at), systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("Read more")
                    .font(.caption.bold())
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 6)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Vista principal de Events (grid con dos columnas)
struct EventsView: View {
    @StateObject private var dataManager = DataManagerEvents()

    // Dos columnas flexibles
    private let columnas = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ScrollView {
            if dataManager.isLoading {
                ProgressView("Cargando Events...")
                    .padding(.top, 40)
            } else if dataManager.events.isEmpty {
                Text("No se encontraron eventos")
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            } else {
                LazyVGrid(columns: columnas, spacing: 18) {
                    ForEach(dataManager.events) { item in
                        NavigationLink(destination: ArticleDetailView(articleId: item.id)) {
                            EventCardView(item: item)
                                .frame(maxWidth: .infinity, minHeight: 200)
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            if dataManager.events.isEmpty {
                dataManager.fetchEvents()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    EventsView()
}
