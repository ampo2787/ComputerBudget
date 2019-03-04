//
//  naverParseEngine.swift
//  ComputerBudget
//
//  Created by JihoonPark on 16/02/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

@objcMembers class naverParseEngine: NSObject {
    
    var Json_Text : String?
    var Name : String?
    var Price : String?
    var ImageURL : String?
    
    func callURL(search : String){
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
                print(str)
                
                //DispatchQueue.main.async {
                    self.Name = self.extractionName(text: str)
                    self.Price = self.extractionPrice(text: str)
                    self.ImageURL = self.extractionImageURL(text: str)
                //}
                
            }
            //통신 실패
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func extractionName(text:String) -> String {
        
        if let data = text.data(using: .utf8){
            let json = try!JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            return json["title"] as! String
            
        }
        else{
            return "fail"
        }
        
    }
    
    func extractionImageURL(text:String) -> String {
        
        if let data = text.data(using: .utf8){
            let json = try!JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            return json["image"] as! String
            
        }
        else{
            return "fail"
        }
    }
    
    func extractionPrice(text:String) -> String {
        if let data = text.data(using: .utf8){
            let json = try!JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            return json["lprice"] as! String
        }
        else{
            return "fail"
        }
    }
    
}
