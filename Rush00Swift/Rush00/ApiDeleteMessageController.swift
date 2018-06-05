//
//  ApiDeleteMessageController.swift
//  Rush00
//
//  Created by Stephane MARTINS on 6/3/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation




class ApiDeleteMessagesController {
    let token: String
    var topicsArray: [Topic]?
    let delegate: APIRefreshMessagesDelegate
    
    init(APIdelegate: APIRefreshMessagesDelegate?, id: Int,  token: String) {
        print("_________DELETE MESSAGES API CALL ________")
        self.token = token
        delegate = APIdelegate!
        let request = setupGetTopicsRequest(id: id)
        let task = URLSession.shared.dataTask(with: request! as URLRequest, completionHandler: getTopics)
        task.resume()
    }
    
    func setupGetTopicsRequest(id: Int) -> NSMutableURLRequest? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/messages/" + String(id)
        
        
//        urlComponents.queryItems = [NSURLQueryItem(name: "page[size]", value: "10") as URLQueryItem]
        
        
        let urlRequest = NSMutableURLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("Bearer " + token  , forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func getTopics(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let err = error {
            print(err)
            return
        }
        if let d = data {
            print("data")
            do {
                if let dic = String(data: d, encoding: .utf8) {
                                    print(dic)
                                }
    
                DispatchQueue.main.async {
                    self.delegate.reloadMessages()
                }
                
            }
            catch (let err) {
                print(err)
            }
        }
    }
    
}


