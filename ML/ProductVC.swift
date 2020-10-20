//
//  ProductVC.swift
//  ML
//
//  Created by Nestor Camela on 17/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
import UIKit
import ApiManager
import Kingfisher

class ProductVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    public var product:MLProduct?
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var specsTable: UITableView!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var sellerLbl: UILabel!
    @IBOutlet var posLbl: UILabel!
    @IBOutlet var negLbl: UILabel!
    @IBOutlet var neutLbl: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = product!.title
        lblPrice.text = "$\(product!.price!)"
        specsTable.dataSource = self
        specsTable.delegate = self
        
        var frame = specsTable.frame
        frame.size.height = specsTable.contentSize.height
        specsTable.frame = frame
        
        specsTable.reloadData()
        specsTable.layoutIfNeeded()
        specsTable.heightAnchor.constraint(equalToConstant: specsTable.contentSize.height).isActive = true
        scrollView.isScrollEnabled = true
        let url = URL(string: product!.thumbnail ?? "https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png")
        self.imageView!.kf.indicatorType = .activity
        self.imageView!.kf.setImage(with: url)
        sellerLbl.text = "Vendedor: \(product!.seller!.name ?? "-") (\(product!.seller!.reputation?.total ?? 0))"
        posLbl.text = "(+) \(product!.seller!.reputation?.positive ?? 0)%"
        negLbl.text = "(-) \(product!.seller!.reputation?.negative ?? 0)%"
        neutLbl.text = "(.)\(product!.seller!.reputation?.neutral ?? 0)%"
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product!.attributes!.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell") as? AttributeCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "AttributeCell", bundle: nil), forCellReuseIdentifier: "AttributeCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell") as? AttributeCell
        }
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let data = product!.attributes![indexPath.row]
        (cell as? AttributeCell)?.setData(data)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    
    
    
    
    
}
