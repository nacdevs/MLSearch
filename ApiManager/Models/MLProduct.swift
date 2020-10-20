//
//  MLProduct.swift
//  ApiManager
//
//  Created by Nestor Camela on 13/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation

public class MLProduct:NSObject{
    public var title:String?
    public var desc:String?
    public var price:Double?
    public var thumbnail:String?
    public var productUrl:String?
    public var availability:Int?
    public var seller:MLSeller?
    public var state : String?
    public var city : String?
    public var attributes:[MLAttributes]?

    
    
    init(json:[String:Any]) {
            super.init()
            self.title = json["title"] as? String ?? ""
            self.price = json["price"] as? Double ?? 2020
            self.thumbnail = json["thumbnail"] as? String ?? ""
            self.productUrl = json["permalink"] as? String ?? ""
            self.availability = json["available_quantity"]as?Int ?? 0
            self.seller = MLSeller(json:(json["seller"] as? [String:Any])!)
            self.state = (json["address"] as? [String: Any])?["state_name"] as? String ?? ""
            self.city = (json["address"] as? [String: Any])?["city_name"] as? String ?? ""
        self.attributes = MLAttributes.getArray(json: json)


        }
    
    static public func getArray(json: [String:Any]) -> Array<MLProduct>{
        
        var array = Array<MLProduct>()
        guard
            let products = json["data"] as? [[String: Any]]
            else {
                print("123 array parse error")
                return array
        }
        for product in products {
            array.append(MLProduct(json: product))
        }
        print("123 array")

        return array
    }
}

