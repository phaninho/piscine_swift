//
//  ApiAddMessageController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/3/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation


protocol APIRefreshMessagesDelegate: class {
    func reloadMessages()
}

class ApiAddMessagesController {
    let token: String
    var topicsArray: [Topic]?
    let delegate: APIRefreshMessagesDelegate
    
    init(APIdelegate: APIRefreshMessagesDelegate?, topicId: Int,  token: String, authorId: Int, content: String) {
        print("_________POST MESSAGE API CALL ________")
        self.token = token
        delegate = APIdelegate!
        let request = setupGetTopicsRequest(topicId: topicId, authorId: authorId, content: content)
        let task = URLSession.shared.dataTask(with: request! as URLRequest, completionHandler: getTopics)
        task.resume()
    }
    
    func setupGetTopicsRequest(topicId: Int, authorId: Int, content: String) -> NSMutableURLRequest? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/v2/topics/" + String(topicId) + "/messages"
        urlComponents.queryItems = [
            NSURLQueryItem(name: "message[author_id]", value: String(authorId)) as URLQueryItem,
            NSURLQueryItem(name: "message[content]", value: content) as URLQueryItem,
        ]
        let urlRequest = NSMutableURLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "POST"
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
                delegate.reloadMessages()
                if let dic = String(data: d, encoding: .utf8) {
                                    print(dic)
                                }
                
            }
            catch (let err) {
                print(err)
            }
        }
    }
    
}

