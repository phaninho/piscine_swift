//
//  ApiGetMessagesController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//


import Foundation



protocol APIMessagesDelegate: class {
    func updateMessages(messagesArray: [Message])
}

class ApiGetMessagesController {
    let token: String
    var topicsArray: [Topic]?
    let delegate: APIMessagesDelegate
    
    init(APIdelegate: APIMessagesDelegate?, id: Int,  token: String) {
        print("_________GET MESSAGES API CALL ________")
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
        urlComponents.path = "/v2/topics/" + String(id) + "/messages"
        urlComponents.queryItems = [NSURLQueryItem(name: "page[size]", value: "10") as URLQueryItem]
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
                let dic = try JSONDecoder().decode([Message].self, from: d)
                var newArray: [Message] = []
                
                for item in dic {
                    newArray.append(item)
                    if item.replies.count != 0 {
                        for rep in item.replies {
                            newArray.append(rep)
                        }
                    }
                }

                DispatchQueue.main.async {
                    self.delegate.updateMessages(messagesArray: newArray)
                }
               
            }
            catch (let err) {
                print(err)
            }
        }
    }
    
}

