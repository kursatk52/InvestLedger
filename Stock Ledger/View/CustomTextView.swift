//
//  CustomTextView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI

struct CustomTextView: View {
    @Binding var symbolName : String
    var body: some View {
        
    }
}

struct CustomTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextView(symbolName: .constant("Hello World"))
    }
}
