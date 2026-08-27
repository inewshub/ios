//
//  FacilitiesView.swift
//  Sistema Uno
//
//  Created by Alumno on 13/10/25.
//

import SwiftUI

// MARK: - Data Manager para Facilities
class DataManagerFacilities: ObservableObject {
    @Published var facilities = [Facility]()
    @Published var isLoading = false

    func fetchFacilities() {
        guard let url = URL(string: Constants.FACILITIES_URL) else {
            print("URL inválida")
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
                print("No se encontraron datos")
                return
            }

            do {
                let result = try JSONDecoder().decode(APIResponse<ItemsPayload<Facility>>.self, from: data)
                DispatchQueue.main.async {
                    self.facilities = result.data.items
                }
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        }.resume()
    }
}

struct FacilitiesView: View {
    @StateObject private var dataManager = DataManagerFacilities()
    @State private var currentIndex = 0
    @State private var mostrarMapa = false
    @State private var facilitySeleccionado: Facility?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: Carousel dinámico con datos reales
                if dataManager.isLoading {
                    ProgressView("Cargando Facilities...")
                } else if dataManager.facilities.isEmpty {
                    Text("No se encontraron Facilities.")
                        .foregroundColor(.gray)
                        .padding(.top, 60)
                } else {
                    TabView(selection: $currentIndex) {
                        ForEach(Array(dataManager.facilities.enumerated()), id: \.offset) { index, item in
                            VStack(alignment: .leading, spacing: 12) {
                                ZStack(alignment: .topTrailing) {
                            
                                    AsyncImage(url: URL(string: item.image_url ?? "")) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.88, height: 200)
                                                .cornerRadius(18)
                                                .clipped()
                                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                        case .failure(_):
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 180)
                                                .foregroundColor(.gray)
                                                .opacity(0.6)
                                        case .empty:
                                            ZStack {
                                                Color.gray.opacity(0.1)
                                                ProgressView()
                                            }
                                            .frame(width: UIScreen.main.bounds.width * 0.88, height: 200)
                                            .cornerRadius(18)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }

                           
                                    Button {
                                        facilitySeleccionado = item
                                        mostrarMapa = true
                                    } label: {
                                        Image(systemName: "mappin.and.ellipse")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .background(Color.black.opacity(0.4))
                                            .clipShape(Circle())
                                    }
                                    .padding(10)                                }

                  
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        HStack(spacing: 3) {
                                            ForEach(0..<5, id: \.self) { star in
                                                Image(systemName: star < (item.stars ?? 0) ? "star.fill" : "star")
                                                    .foregroundColor(star < (item.stars ?? 0) ? .yellow : .gray.opacity(0.4))
                                                    .font(.system(size: 14))
                                            }
                                        }
                                    }

                                    Text(item.description ?? "No description available.")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.horizontal, 24)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: 320)
                    .padding(.horizontal)
                    .animation(.easeInOut, value: currentIndex)
                }
                
                // MARK: Sección fija de Facilities (íconos)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Facilities")
                        .font(.headline)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 18) {
                        HStack(spacing: 40) {
                            FacilityIcon(title: "Generator", systemImage: "bolt.fill")
                            FacilityIcon(title: "Wi-Fi", systemImage: "wifi")
                            FacilityIcon(title: "Cricket", systemImage: "sportscourt")
                        }
                        
                        HStack(spacing: 40) {
                            FacilityIcon(title: "Football", systemImage: "soccerball")
                            FacilityIcon(title: "Library", systemImage: "book.fill")
                            FacilityIcon(title: "Cafeteria", systemImage: "cup.and.saucer.fill")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
                .padding(.horizontal)
            }
            .padding(.vertical, 10)
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            if dataManager.facilities.isEmpty {
                dataManager.fetchFacilities()
            }
        }.sheet(isPresented: $mostrarMapa) {
            if let facility = facilitySeleccionado {
                GoogleMapView(facility: facility)
            }
        }
    }
}

struct FacilityIcon: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemImage)
                .font(.system(size: 20))
                .foregroundColor(Color("coral"))
                .frame(width: 36, height: 36)
                .background(Color("coral").opacity(0.1))
                .cornerRadius(10)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    FacilitiesView()
}
