//
//  AllView.swift
//  inewshub
//
//  Created by seevsk on 12/10/25.
//

import SwiftUI

class DataManagerAll: ObservableObject {
    @Published var all = [Article]()
    @Published var isLoading = false
    
    func ReadAll() {
        guard let url = URL(string: Constants.API_URL) else {
            print("URL invalido")
            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data = data else {
                print("No se encuentran datos para leer")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(APIResponse<ItemsPayload<Article>>.self, from: data)
                DispatchQueue.main.async {
                    self.all = decoded.data.items
                }
            } catch {
                print("Error al decodificar JSON: \(error)")
            }

        }.resume()
    }
}

struct AllView: View {
    @StateObject private var dataManager = DataManagerAll()
    @State private var selectedSection = 0
    @Namespace private var underlineAnimation
    @State private var currentPage = 0

    var body: some View {
        VStack(spacing: 0) {
            headerTabs
            mainTabView
        }
        .onAppear {
            dataManager.ReadAll()
        }
    }
}

// MARK: - Subvistas
private extension AllView {

    // MARK: -  Tabs superiores
    var headerTabs: some View {
        HStack(spacing: 34) {
            SectionTab(title: "All", index: 0, selected: $selectedSection, animation: underlineAnimation)
            SectionTab(title: "News", index: 1, selected: $selectedSection, animation: underlineAnimation)
            SectionTab(title: "Life at Lima", index: 2, selected: $selectedSection, animation: underlineAnimation)
            SectionTab(title: "Events", index: 3, selected: $selectedSection, animation: underlineAnimation)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .padding(.top, 10)
    }

    // MARK: -  Contenido principal con TabView
    var mainTabView: some View {
        TabView(selection: $selectedSection) {
            allSection.tag(0)
            NewsView().tag(1)
            LifeView().tag(2)
            EventsView().tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    // MARK: -  Sección All
    @ViewBuilder
    var allSection: some View {
        if dataManager.isLoading {
            ProgressView("Loading ...")
        } else if dataManager.all.isEmpty {
            Text("No news found")
        } else {
            let top = Array(dataManager.all.prefix(5))
            let rest = Array(dataManager.all.dropFirst(5))

            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    latestNewsHeader
                    topCarousel(top)
                    pageIndicators(top)
                    recommendationsHeader
                    recommendationList(rest)
                }
                .padding(.horizontal)
                .padding(.top, 4)
                .padding(.bottom, 10)
            }
        }
    }

    // MARK: - Header “Latest News”
    var latestNewsHeader: some View {
        HStack {
            Text("Latest News")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color("darkgray"))
            Spacer()
            Button(action: {}) {
                Text("See More")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
    }

    // MARK: - Carrusel de noticias top
    func topCarousel(_ top: [Article]) -> some View {
        ZStack {
            TabView(selection: $currentPage) {
                ForEach(top.indices, id: \.self) { index in
                    let current = top[index]
                    
                    NavigationLink(destination: ArticleDetailView(articleSlug: current.slug)) {
                        ZStack(alignment: .bottomLeading) {
                            AsyncImage(url: URL(string: current.hero_image ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                case .failure(_):
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.75, height: 210)
                            .padding(.horizontal, 20)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .tag(index)

                            VStack(alignment: .leading, spacing: 8) {
                                Text(timeAgo(from: current.published_at))
                                    .font(.system(size: 13, weight: .semibold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                    .background(Color("coral"))
                                    .cornerRadius(6)
                                    .foregroundColor(.white)

                                Text(current.title)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.horizontal, 18)
                            .padding(.bottom, 22)
                        }
                        .padding(.horizontal, 20)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(height: 260)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(height: 270)
        .padding(.top, -28)
    }

    // MARK: -  Indicadores de página
    func pageIndicators(_ top: [Article]) -> some View {
        HStack(spacing: 8) {
            ForEach(0..<top.count, id: \.self) { index in
                Button {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        currentPage = index
                    }
                } label: {
                    Circle()
                        .fill(index == currentPage ? Color("bg-color") : Color.gray.opacity(0.4))
                        .frame(width: 15, height: 15)
                        .animation(.easeInOut, value: currentPage)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, -20)
    }

    // MARK: - Header “Recommendations”
    var recommendationsHeader: some View {
        HStack {
            Text("Recommendations")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.gray)
            Spacer()
            Button(action: {}) {
                Text("See More")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
    }

    // MARK: - Lista de Recomendaciones
    func recommendationList(_ rest: [Article]) -> some View {
        LazyVStack(alignment: .leading, spacing: 14) {
            ForEach(rest) { item in
                NavigationLink(destination: ArticleDetailView(articleSlug: item.slug)) {
                HStack(alignment: .top, spacing: 12) {
                    AsyncImage(url: URL(string: item.hero_image ?? "")) { phase in
                        switch phase {
                        case .empty: ProgressView()
                        case .success(let image):
                            image.resizable().scaledToFill()
                        case .failure(_):
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .padding(8)
                        @unknown default: EmptyView()
                        }
                    }
                    .frame(width: 165, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(item.content_type.capitalized)
                                .font(.system(size: 16.5, weight: .bold))
                                .foregroundColor(Color("coral"))
                            Spacer()
                            Text(formatDate(item.published_at))
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
                }
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    AllView()
}
