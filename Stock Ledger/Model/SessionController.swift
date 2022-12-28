//
//  SessionController.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 26.12.2022.
//

import Foundation
import Firebase
import FirebaseAuth


class SessionController : ObservableObject{
    
    @Published var user : User? = nil
    
    private var handle : AuthStateDidChangeListenerHandle? = nil
    
    public func listen(){
        handle = Auth.auth().addStateDidChangeListener{(ath, usr) in
            if let usr = usr{
                self.user = User(displayName: usr.displayName ?? "None", uid: usr.uid, email: usr.email)
            }else{
                self.user = nil
            }
        }
    }
    
    public func unbind(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    public func signIn(email : String, password: String, handler: ((AuthDataResult?,Error?)->Void)?){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    public func signOut(){
        do{
            try Auth.auth().signOut()
            self.user = nil
        } catch{
            print(error)
        }
    }
    
    public func signUp(email:String, password:String, handler: ((AuthDataResult?,Error?)->Void)?){
        Auth.auth().createUser(withEmail: email, password: password,completion: handler)
    }
    
    
    
}
