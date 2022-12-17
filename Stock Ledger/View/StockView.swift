//
//  StockView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI

struct StockView: View {
    
    @Binding var stockVM : StockModel
    @Binding var currency : String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 170)
                .opacity(0.15)
                .cornerRadius(30)
            HStack{
                VStack(alignment: .trailing){
                    Text("Sembol: ")
                    Text("Alış Fiyat: ")
                    Text("Miktar: ")
                    Text("Hedef Fiyat: ")
                    Text("Beklenen Kar: ")
                }
                .font(.title2)
                .bold(true)
                .foregroundColor(.white)
                
                VStack(alignment: .leading){
                    Text("\(stockVM.symbol)")
                    Text("\(String(format: "%.2f", stockVM.buyPrice)) \(currency)")
                    Text("\(stockVM.amount)")
                    Text("\(String(format: "%.2f",stockVM.targetPrice)) \(currency)")
                    HStack{
                        Text("\(String(format: "%.2f", stockVM.expectedProfit)) \(currency)")
                        Text("(%\(String(format: "%.2f", stockVM.expectedProfitRatio)))")
                            .foregroundColor((stockVM.expectedProfitRatio >= 0) ? .green : .red)
                    }
                }
                .foregroundColor(.white)
                .font(.title2)
                .opacity(0.8)
            }
        }
        .padding(.horizontal)
    }
}


struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stockVM:.constant(StockModel()),currency: .constant("$"))
    }
}

