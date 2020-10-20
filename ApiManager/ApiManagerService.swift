//
//  ApiManager.swift
//  ML
//
//  Created by Nestor Camela on 13/10/2020.
//  Copyright © 2020 Nestor Camela. All rights reserved.
//

import Foundation
import Alamofire
public class ApiManagerService:NSObject {
    
    public static let shared = ApiManagerService()
    public let server = "https://api.mercadolibre.com"

    
    public typealias InitRequest = ()->Void
    public typealias FinishRequest = ()->Void
    public typealias ErrorResponse = (_ status:Int)->Void
    public typealias FatalResponse = ()->Void
    public typealias Response = (_ status:Int, _ response:[String:Any])->Void

    //Busqueda por nombre de producto
    public func getProductsSearch(
         search:String,
         onInitRequest:@escaping InitRequest,
         onFinishRequest: @escaping FinishRequest,
         onError: @escaping ErrorResponse,
         onFatal: @escaping FatalResponse,
         onResponse:@escaping (_ status: Int, _ response: [MLProduct])->Void) {
         let encodedUrl = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

         makeRequestGet(
             url: "\(server)/sites/MLA/search?q=\(encodedUrl!)",
             onInitRequest: onInitRequest,
             onFinishRequest: onFinishRequest,
             onError: onError,
             onFatal: onFatal)
         { (status, jsonResponse) in
            onResponse(status, MLProduct.getArray(json: jsonResponse))
         }
     }
    
    ///Llamada para todos los get
    public func makeRequestGet(
           url:String,
           onInitRequest:@escaping InitRequest,
           onFinishRequest:@escaping FinishRequest,
           onError: @escaping ErrorResponse,
           onFatal: @escaping FatalResponse,
           onResponse:@escaping Response){
           makeRequest(
               url: url,
               params: nil,
               method: HTTPMethod.get,
               onInitRequest: onInitRequest,
               onFinishRequest: onFinishRequest,
               onError: onError,
               onFatal: onFatal,
               onResponse: onResponse
           )
       }
    
    
    /// Realiza la llamada la endpoint
    /// - Parameter url: Espera url completa
    /// - Parameter params: Parametros del request
    /// - Parameter method: tipo de metodo http get/post
    /// - Parameter onInitRequest: Llamado en el comienzo del request
    /// - Parameter onFinishRequest: Llamado al finalizar el request
    /// - Parameter onError: Llamado si se produce un error
    /// - Parameter onResponse: Llamado cuando se obtiene respuesta
    public func makeRequest(
        
        url:String,
        params:Parameters?,
        method:HTTPMethod,
        onInitRequest:@escaping InitRequest,
        onFinishRequest:@escaping FinishRequest,
        onError: @escaping ErrorResponse,
        onFatal:@escaping FatalResponse,
        onResponse:@escaping Response){
        
        onInitRequest()
        print("init Request")
        print("1 URl: \(url)")
        
     
        
        Alamofire.request(
            url,
            method: method,
            parameters: params,
            encoding: JSONEncoding.default).responseJSON { response in
                print("12  Receive: \(response)")
                
                if let httpresponse = response.response{
                    print("123 Status Code: \(httpresponse.statusCode)")
                }
                
                switch response.result {
                    
                case .success:
                    if response.response!.statusCode >= 200 && response.response!.statusCode <= 299 {
                        if let json = response.result.value as? [String:Any]{
                            if let r = json["results"] as? [String:Any] {
                             onResponse((response.response?.statusCode)!,r)
                            } else if let a = json["results"] as? [[String:Any]] {
                                let j: [String:Any]  = ["data":a]
                                print("123 Array response")
                             onResponse((response.response?.statusCode)!,j)
                        }else{
                            print("12 error request")
                            onError(123)
                        }
                    }else{
                        if let json = response.result.value as? [String:Any]{
                            onError(response.response!.statusCode)
                        }
                    }
                
                }
                
                onFinishRequest()
                case .failure(_):
                    onFatal()
                }
        }
    
    
    }
}
