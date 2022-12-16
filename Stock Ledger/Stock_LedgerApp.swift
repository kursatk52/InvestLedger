//
//  Stock_LedgerApp.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import SwiftUI

@main
struct Stock_LedgerApp: App {
    
    @StateObject var stockViewModal = StockViewModal()
    @StateObject var settingsViewModal = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup{
            StockList(stockViewModel: self.stockViewModal,settingsViewModal: self.settingsViewModal)
                .onAppear(){
                    stockViewModal.stocks = StockViewModal.loadStock()
                    settingsViewModal.settings = SettingsViewModel.loadSettings()
                }
        }
    
    }
}
