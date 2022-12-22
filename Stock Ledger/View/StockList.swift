//
//  ContentView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct StockList: View {
    @ObservedObject var stockViewModel : StockViewModal
    @ObservedObject var settingsViewModal : SettingsViewModel
    @State var tabSelection : Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection){
                        Group {
                            VStack {
                                Text("my-stocks",tableName: settingsViewModal.settings.lang)
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                if stockViewModel.stocks.isEmpty{
                                    Text("no-item",tableName: settingsViewModal.settings.lang)
                                        .font(.body)
                                        .padding(.top,50)
                                        .foregroundColor(.gray)
                                }
                                
                                
                                
                                ScrollView(.vertical){
                                            LazyVStack(spacing: 10){
                                                ForEach($stockViewModel.stocks, id: \.id) { $item in
                                                    NavigationLink {
                                                        StockEditView(stockViewModel: stockViewModel,stockModel: $item,currency: $settingsViewModal.settings.currency,language: $settingsViewModal.settings.lang)
                                                    } label: {
                                                        StockView(stockVM: $item,currency: $settingsViewModal.settings.currency,language: $settingsViewModal.settings.lang)
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
                            
                            
                            StockAddView(stockViewModel: stockViewModel, tabSelect: $tabSelection,currency: $settingsViewModal.settings.currency,language: $settingsViewModal.settings.lang)
                                .tabItem {
                                    Image(systemName: "plus.circle")
                                }
                                .tag(1)
                       
                            SettingsView(settingsViewModal: settingsViewModal, tabSelect: $tabSelection)
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
        StockList(stockViewModel: (StockViewModal()),settingsViewModal: SettingsViewModel())
    }
}
