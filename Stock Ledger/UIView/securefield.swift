//
//  securefield.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 22.12.2022.
//

import SwiftUI



struct securefield: View {
    
    @Binding var text : String
    
    var body: some View {
        Rectangle()
            .background(.white)
            .frame(width: 200,height: 40)
            .opacity(0.11)
            .overlay {
                ZStack(alignment: .leading){
                    SecureField("", text: $text)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    
                }
            }
            .cornerRadius(CGFloat.infinity)
    }
}

struct securefield_Previews: PreviewProvider {
    static var previews: some View {
        securefield(text:.constant("password"))
    }
}
