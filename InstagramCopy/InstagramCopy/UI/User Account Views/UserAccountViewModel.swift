//
//  UserAccountViewModel.swift
//  InstagramCopy
//
//  Created by Sebastian Guiscardo on 3/17/23.
//

import Foundation
import FirebaseAuth

struct UserAccountViewModel {
    

func createAccount(email: String, password: String, confirmPassword: String) {
    if password == confirmPassword {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Oh no! there was an error creating your account", error.localizedDescription)
            }
            
            if let authResult {
                let user = authResult.user
                print(user.uid)
                print(user.email)
            }
        }
    } else {
        print("Passwords don't match")
        //todo Present an alert
    }
}

    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("You can't sign in", error.localizedDescription)
            }

            if let result {
                let user = result.user
                print(user.uid)
            }
        }
        
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
