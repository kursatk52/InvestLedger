//
//  StockModelView.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 14.12.2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class StockViewModal : ObservableObject{
    
    @Published var stocks : [StockModel] = []
    private static let db = Firestore.firestore()
    
    static public func loadStock() async ->[StockModel]{
        
        var stockArr : [StockModel] = []
        
        let snapshot = try! await db.collection("stocks").getDocuments()
        
        for stock in snapshot.documents{
            if (stock.data()["uid"] as! String) == Auth.auth().currentUser?.uid{
                stockArr.append(StockModel(symbol: stock.data()["symbol"] as! String, buyPrice: stock.data()["buyPrice"] as! Double, amount: stock.data()["amount"] as! Int,targetPrice: stock.data()["sellPrice"] as! Double))
            }
        }
        print(stockArr.isEmpty ? "Boş" : "Dolu")
        
        return stockArr
    }
    
    /*
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
    */
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
