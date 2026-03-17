//
//  UsersView.swift
//  inewshub
//
//  Created by seevsk on 3/11/25.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var apiManager: UsersApiManager
    @State private var selectedUser: User? = nil

    var body: some View {
        NavigationStack {
            Group {
                if apiManager.isLoading {
                    ProgressView()
                } else if apiManager.users.isEmpty {
                    Text("No hay usuarios registrados")
                        .foregroundColor(.gray)
                        .font(.headline)
                } else {
                    List {
                        ForEach(apiManager.users) { user in
                            DibujarUsuarioView(itemUser: user)
                                .onTapGesture {
                                    self.selectedUser = user
                                }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                apiManager.fetchUsers()
            }
            .sheet(item: $selectedUser) { user in
                            UsersUpdateView(user: user)
                                .environmentObject(apiManager)
                        }
        }
    }
}

struct DibujarUsuarioView: View {
    let itemUser: User

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Username:")
                            .fontWeight(.semibold)
                        Text(itemUser.username)
                    }

                    HStack {
                        Text("Name:")
                            .fontWeight(.semibold)
                        Text(itemUser.name)
                    }

                    HStack {
                        Text("LastName:")
                            .fontWeight(.semibold)
                        Text(itemUser.lastname)
                    }

                    HStack {
                        Text("Email:")
                            .fontWeight(.semibold)
                        Text(itemUser.email)
                    }

                    HStack {
                        Text("Role:")
                            .fontWeight(.semibold)
                        Text(itemUser.role)
                    }

                    if let date = itemUser.created_at {
                        HStack {
                            Text("Joined:")
                                .fontWeight(.semibold)
                            Text(formatDate(date))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }
        }

    #Preview {
        UsersView()
            .environmentObject(UsersApiManager())
    }
