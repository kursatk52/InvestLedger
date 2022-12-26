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
    
    @EnvironmentObject var sessionController : SessionController
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
                                sessionController.signIn(email: username, password: password, handler: nil)
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
                            var changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = "Kursat"
                            changeRequest?.commitChanges(completion: { error in
                                print(error.debugDescription)
                            })
                        } label: {
                            Text("Change name")
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
        LoginView(username: $username,password: $pass)
    }
}
