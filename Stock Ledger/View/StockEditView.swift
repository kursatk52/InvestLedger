//
//  StockSettingView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI

struct StockEditView: View {
    
    @StateObject var stockViewModel : StockViewModal
    @Binding var stockModel : StockModel
    @Binding var currency : String
    @Binding var language : String
    @State private var data : StockModel.Data = StockModel.Data()
    
    @Environment(\.dismiss) private var dismiss
    
    let formatterDecimal : NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        
        return VStack {
            Text("edit-stock", tableName: language)
                .font(.title)
                .bold(true)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            HStack(alignment: .top){
                VStack(alignment: .trailing,spacing: 25){
                    Text("symbol", tableName: language)
                        .font(.title3)
                        .bold(true)
                    
                    Text("buy-price",tableName: language)
                        .font(.title3)
                        .bold(true)
                        
                    Text("amount", tableName: language)
                        .font(.title3)
                        .bold(true)
                        
                    Text("sell-price", tableName: language)
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
                                if data.symbol.isEmpty {
                                    Text("symbol-name", tableName: language)
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                }
                                TextField("",text: $data.symbol)
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
                                TextField("0",value: $data.buyPrice,formatter: formatterDecimal)
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
                            TextField("0",value: $data.amount, formatter: NumberFormatter())
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        }
                        .cornerRadius(CGFloat.infinity)
                    
                    Rectangle()
                        .background(.white)
                        .frame(width: 200,height: 40)
                        .opacity(0.11)
                        .overlay {
                            HStack{
                                TextField("0",value: $data.targetPrice ,formatter: formatterDecimal)
                                    .padding(.leading,20)
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
                    stockModel.update(data:data)
                    StockViewModal.saveStock(stocks: stockViewModel.stocks)
                    dismiss()
                } label: {
                    Text("save",tableName: language)
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
                        stockViewModel.deleteItem(item: stockModel)
                        dismiss()
                    } label: {
                        Text("delete",tableName: language)
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
            
        }.onAppear(){
            self.data = stockModel.data
        }.background(LinearGradient(stops: [
            Gradient.Stop(color: Color("colorOne"),location: 0),
            Gradient.Stop(color: Color("colorTwo"), location: 0.8),
            Gradient.Stop(color: Color("colorThree"), location: 1)],startPoint: .topTrailing, endPoint: .bottomLeading))
        .foregroundColor(.white)
    }
}

struct StockSettingView_Previews: PreviewProvider {
    @State static var den : StockModel = StockModel()
    @State static var den2 : StockViewModal = StockViewModal()
    static var previews: some View {
        StockEditView(stockViewModel: den2,stockModel: $den,currency: .constant("$"),language: .constant("Türkçe"))
    }
}
