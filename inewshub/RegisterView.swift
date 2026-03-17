//
//  RegisterView.swift
//  inewshub
//
//  Created by seevsk on 1/10/25.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var apiManager: UsersApiManager
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showSuccessAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 10) {
                    Circle()
                        .fill(Color("white"))
                        .scaleEffect(2.0)
                        .offset(x: -235, y: -405)
                        .ignoresSafeArea()
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color("white"))
                        .scaleEffect(2.0)
                        .offset(x: 55, y: 510)
                        .ignoresSafeArea()
                }

                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image("logo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 60)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                        
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.trailing, 40)
                        }
                    }
                    .padding(.top, 0)

                    Spacer(minLength: 0)

                    Text("Create Account")
                        .font(.system(size: 47))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, 40)
                        .frame(maxWidth: 250, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .kerning(1.4)

                    Group {
                        CustomTextField(placeholder: "Name", text: $name)
                        CustomTextField(placeholder: "Last Name", text: $lastName)
                        CustomTextField(placeholder: "Username", text: $username)
                        CustomTextField(placeholder: "Email", text: $email)
                        SecureInputField(placeholder: "Password", text: $password)
                    }
                    .padding(.horizontal, 20)

                    Button {
                        apiManager.registerUser(
                            username: username,
                            name: name,
                            lastname: lastName,
                            email: email,
                            password: password
                        ) { result in
                            if result != nil {
                                showSuccessAlert = true
                                clearFields()
                            }
                        }
                    } label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .font(.system(size: 18.5))
                            .fontWeight(.bold)
                            .frame(maxWidth: 250)
                            .padding()
                            .background(Color("coral"))
                            .cornerRadius(50)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .alert("User registered successfully", isPresented: $showSuccessAlert) {
                        Button("OK", role: .cancel) { }
                    }

                    Spacer()

                    HStack {
                        Text("Already have account?")
                            .foregroundColor(Color(.gray))
                            .bold()
                        NavigationLink(destination: LoginView()) {
                            Text("Sign In")
                                .foregroundColor(Color("coral"))
                                .bold()
                        }
                    }
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 30)
                }
            }
            .background(Color("bg-color"))
            .navigationBarBackButtonHidden(true)
        }
    }

    private func clearFields() {
        name = ""
        lastName = ""
        username = ""
        email = ""
        password = ""
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(UsersApiManager())
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color("white").opacity(0.5))
                    .font(.system(size: 18.5))
                    .padding(.vertical, 8)
            }

            TextField("", text: $text)
                .font(.system(size: 17))
                .foregroundColor(Color("white").opacity(0.5))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.vertical, 8)
        }
        .frame(maxWidth: 250)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color("white").opacity(0.5)),
            alignment: .bottom
        )
        .padding(.leading, 30)
    }
}

struct SecureInputField: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color("white").opacity(0.5))
                    .font(.system(size: 18.5))
                    .padding(.vertical, 8)
            }
            
            SecureField("", text: $text)
                .font(.system(size: 17))
                .foregroundColor(Color("white").opacity(0.5))
                .padding(.vertical, 8)
        }
        .frame(maxWidth: 250)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color("white").opacity(0.5)),
            alignment: .bottom
        )
        .padding(.leading, 30)
    }
}
