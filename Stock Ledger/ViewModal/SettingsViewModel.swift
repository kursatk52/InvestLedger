//
//  SettingsViewModel.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 16.12.2022.
//

import Foundation


class SettingsViewModel : ObservableObject{
    
    @Published var settings : SettingsModel = SettingsModel()
    
    static public func loadSettings() -> SettingsModel{
        
        if let jsonURL = Bundle.main.url(forResource: "settings.json", withExtension: nil){
            do{
                let jsonDecoder = JSONDecoder()
                let jsonData = try Data(contentsOf: jsonURL)
                let settingsModel = try jsonDecoder.decode(SettingsModel.self, from: jsonData)
                return settingsModel
            }catch{
                print("Hata")
            }
        }
        return SettingsModel()
    }
    
    static public func saveSettings(settingsModelWillSave : SettingsModel) -> Bool{
        if let saveURL = Bundle.main.url(forResource: "settings.json", withExtension: nil){
            do{
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(settingsModelWillSave)
                try jsonData.write(to: saveURL)
                return true
            }catch{
                return false
            }
        }
        return false
    }
    
}
