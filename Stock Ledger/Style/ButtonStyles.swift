//
//  ButtonStyles.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 12.12.2022.
//

import Foundation
import SwiftUI


struct SaveButtonStyle : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Rectangle()
                .frame(height: 50)
                .cornerRadius(10)
                
            configuration.label
                .foregroundColor(.green)
                .background(.blue)
        }
        .padding(.horizontal)

            
    }
}
