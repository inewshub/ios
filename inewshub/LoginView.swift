//
//  LoginView.swift
//  inewshub
//
//  Created by seevsk on 3/10/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Circle()
                    .fill(Color("bg-color"))
                    .scaleEffect(2.0)
                    .offset(x: -85, y: -305)
                    .ignoresSafeArea()
                
                Spacer()
                
                Circle()
                    .fill(Color("bg-color"))
                    .scaleEffect(2.0)
                    .offset(x: 55, y: 505)
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                
            
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 60)
                        .padding(.leading, 10)
                        .padding(.top, 5)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.trailing, 40)

                            
                    }
                }
                .padding(.top, 0)
                
                
                
                
                Text("Welcome Back!")
                    .font(.system(size: 47))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.leading, 35)
                    .frame(maxWidth: 250, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .kerning(1.4)
                
                Spacer(minLength: 0)
                
                Group {
                    CustomTextFieldLogin(placeholder: "Email", text: $email)
                    SecureInputFieldLogin(placeholder: "Password", text: $password)
                }
                .padding(.horizontal, 40)
               
                HStack {
                    Text("Forget your password?").bold().foregroundColor(.gray)
                }.font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 85)
                
                NavigationLink(destination: DashboardView()) {
                    Text("Login")
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
                
            
                Spacer()
                
                HStack {
                    Text("Doesn't have account?")
                        .foregroundColor(Color(.white))
                        .bold()
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up")
                            .foregroundColor(Color("coral"))
                            .bold()
                    }
                }
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 30)
            }
        }.background(Color("white"))
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    LoginView()
}

struct CustomTextFieldLogin: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 18.5))
                    .padding(.vertical, 8)
                    .bold()
            }

            
            TextField("", text: $text)
                .font(.system(size: 17))
                .foregroundColor(Color(.gray).opacity(0.5))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.vertical, 8)
                .bold()
        }
        .frame(maxWidth: 250)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.gray).opacity(0.5)),
            alignment: .bottom
        )
        .padding(.leading, 30)
    }
}

struct SecureInputFieldLogin: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 18.5))
                    .padding(.vertical, 8)
                    .bold()
            }
            
            SecureField("", text: $text)
                .font(.system(size: 17))
                .foregroundColor(Color(.gray).opacity(0.5))
                .padding(.vertical, 8)
                .bold()
        }
        .frame(maxWidth: 250)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.gray).opacity(0.5)),
            alignment: .bottom
        )
        .padding(.leading, 30)
    }
}
