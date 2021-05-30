//
//  menu.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import Foundation


// Menu 下載
struct MenuResponse :Codable {
    
    let records :[Records]
    
    struct Records :Codable {
        
        let fields :Fields
        
        struct Fields :Codable {
            
            let name :String
            let mediumPrice :Int
            let largePrice :Int
            let describe :String?
        }
    }
}


// 所有 Segment 名稱
enum genreList {
    case 找拿鐵,找奶茶,找好茶,找新鮮
}

enum sizeList {
    case 中杯,大杯
}

enum sugarList {
    case 全糖,少糖,半糖,微糖,無糖
}

enum iceList {
    case 正常,少冰,微冰,去冰,溫熱
}

enum addList {
    case 無,珍珠,波霸,椰果
}


