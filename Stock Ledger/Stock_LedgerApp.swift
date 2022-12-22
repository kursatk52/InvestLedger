//
//  Stock_LedgerApp.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct Stock_LedgerApp: App {
    
    @State var isLogged = false
    @StateObject var stockViewModel = StockViewModal()
    @StateObject var settingsViewModal = SettingsViewModel()
    
    init(){
        FirebaseApp.configure()
        if Auth.auth().currentUser == nil{
            isLogged = false
        }
    }
    @State var username : String = "info@investledger.com"
    @State var password : String = "123456"
    var body: some Scene {
        WindowGroup{
            
            if isLogged{
                StockList(stockViewModel: self.stockViewModel,settingsViewModal: self.settingsViewModal)
                    .onAppear(){
                        stockViewModel.stocks = StockViewModal.loadStock()
                        settingsViewModal.settings = SettingsViewModel.loadSettings()
                    }
                    .onDisappear(){
                        SettingsViewModel.saveSettings(settingsModelWillSave: settingsViewModal.settings)
                        StockViewModal.saveStock(stocks: stockViewModel.stocks)
                    }
            }else{
                LoginView(isLogged: $isLogged,username:$username,password: $password)
            }
            
                
        }
    
    }
}
