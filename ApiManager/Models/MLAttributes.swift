//
//  MLAttributes.swift
//  ApiManager
//
//  Created by Nestor Camela on 17/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
public class MLAttributes:NSObject{
    public var id:String?
    public var name:String?
    public var valueName:String?

    
    init(json:[String:Any]){
        self.id = json["id"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.valueName = json["value_name"] as? String ?? ""
    }
    
    static public func getArray(json: [String:Any]) -> Array<MLAttributes>{
           
           var array = Array<MLAttributes>()
           guard
               let products = json["attributes"] as? [[String: Any]]
               else {
                   print("123 array parse error")
                   return array
           }
           for product in products {
               array.append(MLAttributes(json: product))
           }
           print("123 array attr")
           dump(array)

           return array
       }
}
