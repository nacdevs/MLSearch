//
//  AttributeCell.swift
//  ML
//
//  Created by Nestor Camela on 18/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
import UIKit
import ApiManager
class AttributeCell:UITableViewCell{
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblValueName: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func setData(_ attr:MLAttributes){
        lblName.text = attr.name!
        lblValueName.text = attr.valueName!
    }
    
}
