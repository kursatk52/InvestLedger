//
//  ContentView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI

struct StockList: View {
    @StateObject var stockViewModel : StockViewModal
    @State var tabSelection : Int = 0
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelection){
                        Group {
                            VStack {
                                Text("Hisselerim")
                                    .font(.title)
                                    .bold(true)
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                 
                                    ScrollView(.vertical){
                                            LazyVStack(spacing: 10){
                                                ForEach($stockViewModel.stocks, id: \.id) { $item in
                                                    NavigationLink {
                                                        StockEditView(stockViewModel: stockViewModel,stockModel: $item)
                                                    } label: {
                                                        StockView(stockVM: $item)
                                                    }

                                                }
                                            }
                                    }
                                Spacer()
                                
                            }
                            .tabItem {
                                Image(systemName: "list.bullet.clipboard.fill")
                            }
                            .tag(0)
                            
                            
                            StockAddView(stockViewModel: stockViewModel, tabSelect: $tabSelection)
                                .tabItem {
                                    Image(systemName: "plus.circle")
                                }
                                .tag(1)
                            
                            SettingsView()
                                .tabItem {
                                    Image(systemName: "gearshape.fill")
                                }
                                .tag(2)
                            
                        }.background(LinearGradient(stops: [
                            Gradient.Stop(color: Color("colorOne"),location: 0),
                            Gradient.Stop(color: Color("colorTwo"), location: 0.8),
                            Gradient.Stop(color: Color("colorThree"), location: 1)],startPoint: .topTrailing, endPoint: .bottomLeading))
                        
                    
            }
            .navigationViewStyle(.stack)
            .accentColor(.white)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var svm1 = StockModel(symbol: "GWIND", buyPrice: 12, amount: 5)
   
    static var previews: some View {
        StockList(stockViewModel: (StockViewModal()))
    }
}
