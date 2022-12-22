//
//  textfield.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 22.12.2022.
//

import SwiftUI

struct textfield: View {
    
    @Binding var text : String
    var justDecimal : Bool = false
    
    private let formatterDecimal : NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Rectangle()
            .background(.white)
            .frame(width: 200,height: 40)
            .opacity(0.11)
            .overlay {
                ZStack(alignment: .leading){
                    
                    if justDecimal{
                        TextField("", value: $text,formatter: formatterDecimal)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    }else{
                        TextField("", text: $text)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    }
                    
                }
            }
            .cornerRadius(CGFloat.infinity)
    }
}

struct textfield_Previews: PreviewProvider {
    static var previews: some View {
        textfield(text: .constant("kursatk52"))
    }
}
