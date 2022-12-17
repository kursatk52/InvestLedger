//
//  StockModel.swift
//  Stock Ledger
//
//  Created by Kursat Korkmaz on 11.12.2022.
//

import Foundation

struct StockModel: Hashable, Codable{
    var id : UUID
    var symbol : String
    var buyPrice : Double
    var amount : Int
    var targetPrice : Double
    var expectedProfit : Double{
        return (targetPrice - buyPrice) * Double(amount);
    }
    
    var expectedProfitRatio : Double{
        return (((targetPrice * 100)/buyPrice) - 100.0)
    }
    
    init(id: UUID = UUID(), symbol: String, buyPrice: Double, amount: Int, targetPrice: Double = 0) {
        self.id = id
        self.symbol = symbol
        self.buyPrice = buyPrice
        self.amount = amount
        self.targetPrice = targetPrice
    }
    
    init() {
        self.id = UUID()
        self.symbol = ""
        self.buyPrice = 0
        self.amount = 0
        self.targetPrice = 0
    }

}

extension StockModel{
    
    struct Data{
        var symbol : String = "";
        var buyPrice : Double = 0;
        var amount : Int = 0;
        var targetPrice : Double = 0;
        init(symbol: String, buyPrice: Double, amount: Int, targetPrice: Double) {
            self.symbol = symbol
            self.buyPrice = buyPrice
            self.amount = amount
            self.targetPrice = targetPrice
        }
        
        init(){
            
        }
    }
    
    var data : Data{
        get{
            Data(symbol: symbol, buyPrice: buyPrice, amount: amount, targetPrice: targetPrice)
        }
        set{
            self.symbol = newValue.symbol
            self.buyPrice = newValue.buyPrice
            self.amount = newValue.amount
            self.targetPrice = newValue.targetPrice
        }
    }
    
    mutating func update(data : Data){
        self.symbol = data.symbol;
        self.buyPrice = data.buyPrice;
        self.amount = data.amount;
        self.targetPrice = data.targetPrice;
    }
    
}
