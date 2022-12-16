//
//  StockAddView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 14.12.2022.
//

import SwiftUI

struct StockAddView: View {
    
    @StateObject var stockViewModel : StockViewModal
    @Binding var tabSelect : Int
    @State private var stockModel : StockModel = StockModel()
    @State private var isError : Bool = false
    
    let formatterDecimal : NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    var body: some View {
        VStack {
            Text("Yeni Hisse Ekle")
                .font(.title)
                .bold(true)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            HStack(alignment: .top){
                VStack(alignment: .trailing,spacing: 25){
                    Text("Sembol: ")
                        .font(.title3)
                        .bold(true)
                    
                    Text("Alış Fiyatı: ")
                        .font(.title3)
                        .bold(true)
                        
                    Text("Miktar: ")
                        .font(.title3)
                        .bold(true)
                        
                    Text("Hedef Fiyat: ")
                        .font(.title3)
                        .bold(true)
                }.padding(.top,5)
                
                
                VStack(alignment: .leading){
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            ZStack(alignment: .leading){
                                if stockModel.symbol.isEmpty {
                                    Text("Sembol İsmi")
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                }
                                TextField("",text: $stockModel.symbol)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                            }
                        }
                        .cornerRadius(CGFloat.infinity)
                    
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            HStack{
                                TextField("Alış Fiyatı",value: $stockModel.buyPrice,formatter: formatterDecimal)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                Spacer()
                                Image(systemName: "dollarsign")
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                            }
                        }
                        .cornerRadius(CGFloat.infinity)
  
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            TextField("Miktar",value: $stockModel.amount, formatter: NumberFormatter())
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        }
                        .cornerRadius(CGFloat.infinity)
                    
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            HStack{
                                TextField("Hedef Fiyatı",value: $stockModel.targetPrice ,formatter: formatterDecimal)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                Spacer()
                                Image(systemName: "dollarsign")
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                            }
                        }
                        .cornerRadius(CGFloat.infinity)
                }

            }
            
            
            VStack {
                Button {
                    stockViewModel.appendItem(item: stockModel)
                    stockModel.id = UUID()
                } label: {
                    Text("Ekle")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .bold(true)
                }
                
                .frame(maxWidth: .infinity)
                .background(Color("colorSaveButton"))
                .cornerRadius(10)
                .padding(.horizontal)
                
                HStack {
                    Button {
                        stockModel = StockModel(symbol: "EX", buyPrice: 0, amount: 0,targetPrice:0)
                        tabSelect = 0
                    } label: {
                        Text("İptal")
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .bold(true)
                    }
                    .frame(maxWidth: 150)
                    .background(Color("colorDiscardButton"))
                    .cornerRadius(10)
                .padding(.horizontal)
                    
                    Spacer()
                }
                
   
            }
            .padding(.top,20)
            Spacer()
            
        }.background(LinearGradient(stops: [
            Gradient.Stop(color: Color("colorOne"),location: 0),
            Gradient.Stop(color: Color("colorTwo"), location: 0.8),
            Gradient.Stop(color: Color("colorThree"), location: 1)],startPoint: .topTrailing, endPoint: .bottomLeading))
        .foregroundColor(.white)
        .onAppear(){
            stockModel = StockModel()
        }
        
    }
}


struct StockAddView_Previews: PreviewProvider {
    @State static var tabSelect : Int = 0
    @StateObject static var sVM = StockViewModal()
    static var previews: some View {
        StockAddView(stockViewModel: sVM,tabSelect: $tabSelect)
    }
}
