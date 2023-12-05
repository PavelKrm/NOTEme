//
//  AuthService.swift
//  NoteMe
//
//  Created by PavelKrm on 5.12.23.
//

import Foundation
import Firebase

final class AuthService {
    
    private var firebase: Auth {
        return Auth.auth()
    }
    
    func signIn(email: String,
                pass: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        firebase.signIn(withEmail: email, password: pass) { result, error in
            
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
