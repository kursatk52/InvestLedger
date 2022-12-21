//
//  StockModelView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 14.12.2022.
//

import Foundation
import SwiftUI

class StockViewModal : ObservableObject{
    
    @Published var stocks : [StockModel] = []
    
    static public func loadStock()->[StockModel]{
        
        if let jsonURL = Bundle.main.url(forResource: "stocks.json", withExtension: nil){
            let jsonDecoder = JSONDecoder()
            do{
                let jsonData = try Data(contentsOf: jsonURL)
                let jsonParsedStock = try jsonDecoder.decode([StockModel].self, from: jsonData)
                return jsonParsedStock
            }catch{
                print(error)
            }
            
        }
        
        print("Stocks file couldn't found!")
        return []
    }
    
    static public func saveStock(stocks: [StockModel]){
        if let jsonURL = Bundle.main.url(forResource: "stocks.json", withExtension: nil){
            let jsonEncoder = JSONEncoder()
            do{
                let jsonData = try jsonEncoder.encode(stocks)
                try jsonData.write(to: jsonURL)
            }catch{
                print(error)
            }
        }else{
            print("Stocks file couldn't found!")
        }
    }
    
    
    func deleteItem(item : StockModel){
        for (smindex,smitem) in stocks.enumerated(){
            if smitem.id == item.id{
                stocks.remove(at: smindex)
            }
        }
    }
    
    func appendItem(item : StockModel) {
        stocks.append(item)
    }
    
}
