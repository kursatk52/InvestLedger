//
//  loginView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 22.12.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseCoreExtension

struct LoginView: View {
    
    @Binding var isLogged : Bool
    @Binding var username : String
    @Binding var password : String
    @State private var isWrong : Bool = false
    
    var body: some View {
        HStack{
            Spacer()
            VStack {
                Spacer()
                textfield(text: $username)
                securefield(text: $password)
                
                    Rectangle()
                        .fill(.white)
                        .frame(width: 150,height: 30)
                        .cornerRadius(.infinity)
                        .overlay {
                            Button {
                                Auth.auth().signIn(withEmail: username, password: password) { Authresult, error in
                                    
                                    
                                    if let result = Authresult?.user.email{
                                        if result == username{
                                            isLogged = true
                                            isWrong = false
                                        }else{
                                            isLogged = false
                                            isWrong = true
                                        }
                                        
                                    }else{
                                        print("nil")
                                    }
                                    
                                    print(error.debugDescription)
                                    
                                    
                                    
                                    
                                    if let err = error{
                                        var authError = err as NSError
                                        if authError.code == 17011 || authError.code == 17009{
                                            isWrong = true
                                        }
                                    }
                                }
                            } label: {
                                Text("LogIN")
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                            }
                        }
                
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 150,height: 30)
                    .cornerRadius(.infinity)
                    .overlay {
                        Button {
                            Auth.auth().createUser(withEmail: username, password: password) { result, error in
                                print("Result: " , result.debugDescription)
                            }
                        } label: {
                            Text("Register")
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                        }
                    }
                
                if isWrong{
                    Text("Your username or password is wrong!\nPlease try again")
                        .padding(.top,15)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
            
            Spacer()
            
        }.background(LinearGradient(stops: [
            Gradient.Stop(color: Color("colorOne"),location: 0),
            Gradient.Stop(color: Color("colorTwo"), location: 0.8),
            Gradient.Stop(color: Color("colorThree"), location: 1)],startPoint: .topTrailing, endPoint: .bottomLeading))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var username : String = "info@investledger.com"
    @State static var pass : String = "123456"
    static var previews: some View {
        LoginView(isLogged: .constant(false),username: $username,password: $pass)
    }
}
