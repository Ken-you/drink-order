//
//  order.swift
//  drink-order
//
//  Created by yousun on 2021/5/27.
//

import Foundation

// 訂單下載、上傳
struct OrderResponse :Codable {
    
    let records :[Records]
}

struct Records :Codable {
    
    // 根據 id 去刪除
    let id :String
    let fields :OrderItem
}

struct OrderItem :Codable {
    
    let name :String
    let drink :String
    let size :String
    let sugar :String
    let ice :String
    let add :String
    let remark :String?
    let price :Int
}

struct Postrecord :Codable{
    
    var fields :OrderItem
}


