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
    @Binding var currency : String
    @Binding var language : String
    @State private var stockModel : StockModel = StockModel()
    @State private var isError : Bool = false
    
    let formatterDecimal : NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    var body: some View {
        VStack {
            Text("add-new-stock",tableName: language)
                .font(.title.bold())
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            HStack(alignment: .top){
                VStack(alignment: .trailing,spacing: 25){
                    Text("symbol",tableName: language)
                        .font(.title3.bold())
                    
                    Text("buy-price",tableName: language)
                        .font(.title3.bold())
                        
                    Text("amount",tableName: language)
                        .font(.title3.bold())
                        
                    Text("sell-price",tableName: language)
                        .font(.title3).bold()
                }.padding(.top,5)
                
                
                VStack(alignment: .leading){
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            ZStack(alignment: .leading){
                                if stockModel.symbol.isEmpty {
                                    Text("symbol-name",tableName: language)
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
                                TextField("0",value: $stockModel.buyPrice,formatter: formatterDecimal)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                Spacer()
                                Text("\(currency)")
                                    .font(.title2)
                                    .padding(.trailing,15)
                            }
                        }
                        .cornerRadius(CGFloat.infinity)
  
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            TextField("0",value: $stockModel.amount, formatter: NumberFormatter())
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        }
                        .cornerRadius(CGFloat.infinity)
                    
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            HStack{
                                TextField("0",value: $stockModel.targetPrice ,formatter: formatterDecimal)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                Spacer()
                                Text("\(currency)")
                                    .font(.title2)
                                    .padding(.trailing,15)
                            }
                        }
                        .cornerRadius(CGFloat.infinity)
                }

            }
            
            
            VStack {
                Button {
                    stockViewModel.appendItem(item: stockModel)
                    StockViewModal.saveStock(stocks: stockViewModel.stocks)
                    stockModel.id = UUID()
                } label: {
                    Text("add",tableName: language)
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .font(.body.bold())
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
                        Text("discard",tableName: language)
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .frame(maxWidth: .infinity)
                            .font(.body.bold())
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
        StockAddView(stockViewModel: sVM,tabSelect: $tabSelect,currency: .constant("$"),language: .constant("Türkçe"))
    }
}
