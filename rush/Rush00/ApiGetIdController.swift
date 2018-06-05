//
//  ApiGetIdController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/3/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation


protocol APIIdDelegate: class {
    func saveId(id: Int)
}

class ApiGetIdController {
    let token: String
    var topicsArray: [Topic]?
    let delegate: APIIdDelegate
    
    init(APIdelegate: APIIdDelegate?, token: String) {
        print("_________GET ID API CALL ________")
        self.token = token
        delegate = APIdelegate!
        let request = setupGetTopicsRequest()
        let task = URLSession.shared.dataTask(with: request! as URLRequest, completionHandler: getTopics)
        task.resume()
    }
    
    func setupGetTopicsRequest() -> NSMutableURLRequest? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/me"
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
                let dic = try JSONDecoder().decode(Me.self, from: d)
                DispatchQueue.main.async {
                    self.delegate.saveId(id: dic.id)
                }
                
                
            }
            catch (let err) {
                print(err)
            }
        }
    }
    
}

