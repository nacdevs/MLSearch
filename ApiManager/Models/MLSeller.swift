//
//  MLSeller.swift
//  ApiManager
//
//  Created by Nestor Camela on 17/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation

public class MLSeller:NSObject{
    public var id:Int?
    public var name:String?
    public var perma:String?
    public var carDealer:Bool?
    public var reputation:MLRep?
   
    
    init(json:[String:Any]) {
        super.init()
        self.id = json["id"] as? Int ?? 0
        self.name = (json["eshop"] as? [String: Any])?["nick_name"] as? String ?? ""
        self.perma = json["permalink"] as? String ?? ""
        self.carDealer = json["car_dealer"] as? Bool ?? false
        if(json["seller_reputation"] != nil){
            self.reputation = MLRep(json: json["seller_reputation"] as! [String:Any])
        }
    
        print("Name-->\(self.name!)")
    }

    
}
