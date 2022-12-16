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
        return [StockModel()]
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
