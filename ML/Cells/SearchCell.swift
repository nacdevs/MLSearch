//
//  SearchCell.swift
//  ML
//
//  Created by Nestor Camela on 19/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
import UIKit
import ApiManager

class SearchCell : UITableViewCell{
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    override func awakeFromNib() {
        
    }
    

    func setData(_ product:MLProduct){
            lblTitle.text = product.title
            lblPrice.text = "$ \(product.price!)"
            lblCity.text = product.city!

            self.imgView!.clipsToBounds = true
            let url = URL(string: product.thumbnail ?? "https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png")
            self.imgView!.kf.indicatorType = .activity
            self.imgView!.kf.setImage(with: url)

        }
}
