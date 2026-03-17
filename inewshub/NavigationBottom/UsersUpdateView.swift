//
//  UsersUpdateView.swift
//  inewshub
//
//  Created by seevsk on 13/12/25.
//

import SwiftUI

struct UsersUpdateView: View {
    @EnvironmentObject var apiManager: UsersApiManager
    @Environment(\.dismiss) var dismiss

    @State private var userEditable: User
    @State private var showAlert = false
    @State private var alertMessage = ""

    init(user: User) {
        _userEditable = State(initialValue: user)
    }

    var body: some View {
        VStack(spacing: 16) {

            Text("Update User")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            Text("ID: \(userEditable.id)")
                .font(.subheadline)
                .foregroundColor(.gray)

            TextField("Username", text: $userEditable.username)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            TextField("Name", text: $userEditable.name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            TextField("Last name", text: $userEditable.lastname)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            TextField("Email", text: $userEditable.email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Picker("Role", selection: $userEditable.role) {
                Text("User").tag("user")
                Text("Editor").tag("editor")
            }
            .pickerStyle(.menu)
            .padding(.horizontal)

            HStack(spacing: 20) {

                Button("Update") {
                    apiManager.updateUser(
                        id: userEditable.id,
                        username: userEditable.username,
                        name: userEditable.name,
                        lastname: userEditable.lastname,
                        email: userEditable.email,
                        role: userEditable.role
                    ) { success in
                        if success {
                            alertMessage = "User updated successfully"
                        } else {
                            alertMessage = "Error updating user"
                        }
                        showAlert = true
                        apiManager.fetchUsers()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)


                Button("Delete") {
                    apiManager.deleteUser(id: userEditable.id) { success in
                        if success {
                            alertMessage = "User deleted successfully"
                        } else {
                            alertMessage = "Error deleting user"
                        }
                        showAlert = true
                        apiManager.fetchUsers()
                    }
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
            .padding(.top, 10)
        }
        .padding(20)
        .alert(alertMessage, isPresented: $showAlert) {
            Button("Close", role: .cancel) {
                dismiss()
            }
        }
    }
}
