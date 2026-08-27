//
//  ArticleDetailView.swift
//  inewshub
//
//  Created by seevsk on 2/11/25.
//

import SwiftUI

// MARK: - Data Manager para detalle de artículo
class DataManagerArticleDetail: ObservableObject {
    @Published var article: Article?
    @Published var relatedArticles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchArticleDetail(slug: String) {
        guard let url = URL(string: "\(Constants.API_URL)/\(slug)") else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { self.isLoading = false }

            if let error = error {
                DispatchQueue.main.async { self.errorMessage = error.localizedDescription }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { self.errorMessage = "No data received" }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(APIResponse<Article>.self, from: data)
                DispatchQueue.main.async {
                    self.article = decoded.data
                    // Trae artículos del mismo tipo
                    self.fetchRelatedArticles(of: decoded.data.content_type)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decode error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func fetchRelatedArticles(of type: String) {
        guard let url = URL(string: "\(Constants.API_URL)?type=\(type)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            if let decoded = try? JSONDecoder().decode(APIResponse<ItemsPayload<Article>>.self, from: data) {
                DispatchQueue.main.async {
                    self.relatedArticles = Array(decoded.data.items.prefix(3))
                }
            }
        }.resume()
    }
}

// MARK: - Vista de detalle de artículo
struct ArticleDetailView: View {
    let articleSlug: String
    @StateObject private var dataManager = DataManagerArticleDetail()

    var body: some View {
        ScrollView {
            if dataManager.isLoading {
                ProgressView("Loading...")
                    .padding(.top, 50)
            } else if let article = dataManager.article {
                VStack(alignment: .leading, spacing: 15) {
                    
                    // MARK: Imagen principal
                    AsyncImage(url: URL(string: article.hero_image ?? "")) { phase in
                        switch phase {
                        case .empty: ProgressView()
                        case .success(let image):
                            image.resizable().scaledToFill()
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray.opacity(0.4))
                        @unknown default: EmptyView()
                        }
                    }
                    .frame(height: 220)
                    .clipped()
                    .cornerRadius(14)
                    .padding(.horizontal)
                    
                    // MARK: Logo + Fecha
                    HStack {
                        Image("logo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 40)
                        Spacer()
                        Label(formatDate(article.published_at), systemImage: "calendar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
                    
                    // MARK: Título
                    Text(article.title)
                        .font(.title3.bold())
                        .foregroundColor(Color("darkgray"))
                        .padding(.horizontal, 20)
                        .padding(.top, 2)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    // MARK: Cuerpo del artículo
                    Text(article.body ?? "")
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    
                    // MARK: Header “Latest News”
                    HStack {
                        Text("Latest News")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.gray)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    
                    // MARK: Lista de artículos relacionados (idéntica a recommendationList)
                    LazyVStack(alignment: .leading, spacing: 14) {
                        ForEach(dataManager.relatedArticles) { item in
                            NavigationLink(destination: ArticleDetailView(articleSlug: item.slug)) {
                                HStack(alignment: .top, spacing: 12) {
                                    AsyncImage(url: URL(string: item.hero_image ?? "")) { phase in
                                        switch phase {
                                        case .empty:
                                            ZStack {
                                                Color.gray.opacity(0.1)
                                                ProgressView()
                                            }
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure(_):
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(8)
                                                .foregroundColor(.gray.opacity(0.6))
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 165, height: 108)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .clipped()
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack {
                                            Text(item.content_type.capitalized)
                                                .font(.system(size: 16.5, weight: .bold))
                                                .foregroundColor(Color("coral"))
                                            Spacer()
                                            Label(formatDate(item.published_at), systemImage: "calendar")
                                                .font(.caption)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                        Text(item.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                            .lineLimit(3)
                                            .multilineTextAlignment(.leading)
                                        HStack {
                                            Spacer()
                                            Text("Read More")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                }
            } else if let error = dataManager.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("No data found")
                    .foregroundColor(.gray)
                    .padding(.top, 50)
            }
        }
        .onAppear {
            dataManager.fetchArticleDetail(slug: articleSlug)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(articleSlug: "peru-emergency-lima-callao")
    }
}
