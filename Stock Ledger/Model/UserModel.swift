//
//  UserModel.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 26.12.2022.
//

import Foundation
import FirebaseAuth

struct User{
    var uid : String
    var displayName : String?
    var email : String?
    
    
    init(displayName: String?, uid: String, email: String?) {
        self.displayName = displayName
        self.uid = uid
        self.email = email
    }
}
