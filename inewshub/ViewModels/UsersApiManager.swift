//
//  UsersApiManager.swift
//  inewshub
//
//  Created by seevsk on 3/11/25.
//

import Foundation

@MainActor
class UsersApiManager: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false

    func fetchUsers() {
        guard let url = URL(string: "\(Constants.USERS_URL)users.php") else { return }
        isLoading = true
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode([User].self, from: data)
                self.users = decoded
            } catch {
                self.users = []
            }
            isLoading = false
        }
    }

    func registerUser(username: String, name: String, lastname: String, email: String, password: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(Constants.USERS_URL)register.php") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString =
        "username=\(username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&lastname=\(lastname.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&email=\(email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&password=\(password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"

        request.httpBody = postString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let result = String(data: data, encoding: .utf8) {
                    completion(result)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
    func updateUser(
        id: Int,
        username: String,
        name: String,
        lastname: String,
        email: String,
        role: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard let url = URL(string: "\(Constants.USERS_URL)update.php") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString =
        "id=\(id)&username=\(username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&lastname=\(lastname.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&email=\(email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&role=\(role.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"

        request.httpBody = postString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                completion(data != nil)
            }
        }.resume()
    }
    func deleteUser(id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(Constants.USERS_URL)delete.php") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString = "id=\(id)"
        request.httpBody = postString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data != nil)
            }
        }.resume()
    }
}
