//
//  ApiCallsController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation


protocol APIDelegate: class {
    func loadForum(topicsArray: [Topic])
}

class ApiGetTopicsController {
    let token: String
    var topicsArray: [Topic]?
    let delegate: APIDelegate
    var task: URLSessionDataTask?
    
    init(APIdelegate: APIDelegate?, token: String) {
        print("_________API CALLS CONTROLLER________")
        self.token = token
        delegate = APIdelegate!
        let request = setupGetTopicsRequest()
        task = URLSession.shared.dataTask(with: request! as URLRequest, completionHandler: getTopics)
        task!.resume()
    }
    
    func setupGetTopicsRequest() -> NSMutableURLRequest? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/topics"
        let urlRequest = NSMutableURLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer " + token  , forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func getTopics(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let err = error {
            print(err)
            return
        }
        if let d = data {
            do {
                let dic = try JSONDecoder().decode([Topic].self, from: d)
                
                DispatchQueue.main.async {
                    self.delegate.loadForum(topicsArray: dic)
 
                }
            }
            catch (let err) {
                print(err)
            }
        }
    }
    
}



