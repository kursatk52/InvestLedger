//
//  Stock_LedgerApp.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI

@main
struct Stock_LedgerApp: App {
    
    @StateObject var stockViewModel = StockViewModal()
    @StateObject var settingsViewModal = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup{
            StockList(stockViewModel: self.stockViewModel,settingsViewModal: self.settingsViewModal)
                .onAppear(){
                    stockViewModel.stocks = StockViewModal.loadStock()
                    settingsViewModal.settings = SettingsViewModel.loadSettings()
                }
                .onDisappear(){
                    SettingsViewModel.saveSettings(settingsModelWillSave: settingsViewModal.settings)
                    StockViewModal.saveStock(stocks: stockViewModel.stocks)
                }
                
        }
    
    }
}
