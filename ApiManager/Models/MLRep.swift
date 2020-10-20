//
//  MLRep.swift
//  ApiManager
//
//  Created by Nestor Camela on 17/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
public class MLRep:NSObject{
    public var total : Int?
      public var positive:Double?
      public var negative:Double?
      public var neutral:Double?
    
      
      init(json:[String:Any]) {
          super.init()
          self.total = (json["transactions"] as? [String: Any])?["total"] as? Int ?? 0

          self.positive = ((json["transactions"]
          as? [String: Any])?["ratings"]
          as? [String: Any])?["positive"] as? Double ?? 00.00
        
          self.negative = ((json["transactions"]
          as? [String: Any])?["ratings"]
          as? [String: Any])?["negative"] as? Double ?? 00.00
        
          self.neutral = ((json["transactions"]
          as? [String: Any])?["ratings"]
          as? [String: Any])?["neutral"] as? Double ?? 00.00
         
        print("Total: \(self.total!) -- Positive: \(self.positive!)")
      }
}
