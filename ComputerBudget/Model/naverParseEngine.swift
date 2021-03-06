//
//  naverParseEngine.swift
//  ComputerBudget
//
//  Created by JihoonPark on 16/02/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

@objcMembers class naverParseEngine: NSObject {
    
    var productList : Dictionary<String, String> = Dictionary.init()
    var priceList : Dictionary<String, String> = Dictionary.init()
    var imageURLList : Dictionary<String, String> = Dictionary.init()
    
    func callURL(search : String, key : String){
        let ClientID = "MfBgutVQe5VQcXPIvvjH"
        let ClientSecret = "ppbyHNxhzR"
        
        let url1 = "https://openapi.naver.com/v1/search/shop.json?query="
        let addQuery = url1+search
        let encoded = addQuery.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        //한글 검색어도 사용할 수 있도록 함
        
        //Request
        var request = URLRequest(url: URL(string: encoded!)!)
        request.httpMethod = "GET"                 //Naver 도서 API는 GET
        request.addValue(ClientID,forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(ClientSecret,forHTTPHeaderField: "X-Naver-Client-Secret")
        
        //Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //Task
        let task = session.dataTask(with: request) { (data, response, error) in
            //통신 성공
            if let data = data {
                let str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
                
                DispatchQueue.main.async {
                    
                    if let data = str.data(using: .utf8){
                        let json = try!JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                        let items = json["items"] as! NSArray
                        let itemsData = try!JSONSerialization.data(withJSONObject: items, options:[])
                        let itemsJson = try!JSONSerialization.jsonObject(with: itemsData, options: []) as! NSArray
                        let itemsZero = itemsJson[0] as! NSDictionary
                        
                        self.productList[key] = self.extractionName(text: itemsZero["title"] as! String)
                        
                        self.priceList[key] = itemsZero["lprice"] as? String
                        self.imageURLList[key] = itemsZero["image"] as? String
                        
                    }
                }
                
            }
            //통신 실패
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func extractionName(text:String) -> String {
        var title = text.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "") //쓰레기 값 제거.
        return title
    }
    
    func getProductList() -> Dictionary<String, String> {
        return productList
    }
    
    func getPriceList() -> Dictionary<String, String> {
        return priceList
    }
    func getImageList() -> Dictionary<String, String> {
        return imageURLList
    }

    
}
