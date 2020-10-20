//
//  ViewController.swift
//  ML
//
//  Created by Nestor Camela on 13/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import UIKit
import ApiManager
class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var searchTable: UITableView!
    
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    
    var search = [MLProduct]()
    var stringSearch: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.delegate = self
        searchTable.dataSource = self
        self.title = "Busqueda"
        indicator.color = UIColor.black
        loadSearch()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let productvc = storyBoard.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        productvc.product = search[indexPath.row]; self.navigationController!.pushViewController(productvc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.count == 0 {
            //tableView.setEmptyMessage("Nada por aqui")
            tableView.showActivityIndicator()
        } else {
            tableView.restore()
        }
        return search.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? SearchCell
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let searchData = search[indexPath.row]
        (cell as? SearchCell)?.setData(searchData)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
    
    /// Llamada a la libreria
    func loadSearch(){
        ApiManagerService.shared.getProductsSearch(search: stringSearch!, onInitRequest: {
            //
        }, onFinishRequest: {
            //
        }, onError: { (status) in
            print("error en Busqueda")
            
        }, onFatal: {
            let alert = UIAlertController(title: "Error", message: "Por favor revise su conexion e intente nuevamente", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: {
                self.navigationController!.popViewController(animated: true)
            })
            
        }) { (status, arraySearch) in
            self.search = arraySearch
            self.searchTable.reloadData()
            self.indicator.isHidden = true
            self.indicator.removeFromSuperview()
            self.searchTable.isHidden = false
        }
    }
    
    
    
}

extension UIImageView{
    
    func setRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

