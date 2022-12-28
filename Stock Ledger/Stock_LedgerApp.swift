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
    
    @StateObject var sessionController : SessionController = SessionController()
    @StateObject var stockViewModel = StockViewModal()
    @StateObject var settingsViewModal = SettingsViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    @State var username : String = "info@investledger.com"
    @State var password : String = "123456"
    
    
    
    var body: some Scene {
        sessionController.listen()
        return WindowGroup{
            
            Group{
                if sessionController.user != nil {
                    StockList(stockViewModel: self.stockViewModel,settingsViewModal: self.settingsViewModal)
                        .onAppear(){
                            settingsViewModal.settings = SettingsViewModel.loadSettings()
                            print("Appear")
                        }
                        .onDisappear(){
                            SettingsViewModel.saveSettings(settingsModelWillSave: settingsViewModal.settings)
                            StockViewModal.saveStock(stocks: stockViewModel.stocks)
                            print("Disappear")
                        }
                }else{
                    LoginView(username:$username,password: $password)
                }
            }.environmentObject(sessionController)
             
        }
    }
        
}
