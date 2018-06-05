//
//  ViewController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, APIIdDelegate, LogoutDelegate {
    func logout() {

        self.dismiss(animated: true, completion: nil)
      navigationController?.popViewController(animated: true)
    }
    
    func saveId(id: Int) {
        myId = id
    }
    
    var apiViewController : ApiGetIdController?
    var forumView : ForumViewController?
    var webView: WKWebView!
    let CLIENT_ID = "5f59be975ba4534b0832ce23924a7ccdb18181cb67e391e89aca4d44cad849ca"
    let SECRET_ID = "972ffb67fc62278f14f536992af486cb22b504125c50941047aef1fbc5eac969"
    var code: String?
    var urlRequest: NSMutableURLRequest?
    
    var myId: Int? {
        didSet {
            print("ID----> ", myId!)
            DispatchQueue.main.async {
                self.forumView = ForumViewController()
                self.forumView!.token = self.token!
                self.forumView!.myId = self.myId!
                self.forumView!.delegate = self
                self.navigationController?.pushViewController(self.forumView!, animated: true)
            }
        }
    }
    var token: String? {
        didSet {
            guard let _ = token else {return}
            print("TOKEN ---> ", token!)
            apiViewController = ApiGetIdController(APIdelegate: self, token: token!)
        }
    }

    var randomString : String?
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.uiDelegate = self

//        webView.frame = view.bounds
//        disableAutocomplete()
        
        view = webView
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url, let query = url.query else { return }
//        print("URL", url, "\nQUERY", query)
        if query.range(of: "code=")?.lowerBound.encodedOffset == 0 {
            let codeWithAnd = query.components(separatedBy: "=")[1]
            let code = codeWithAnd.components(separatedBy: "&")[0]
            print("_____________________ CODE ______________________" , code)
            let urlRequest = setupAccessTokenURL(code: code)
            let task  = URLSession.shared.dataTask(with: urlRequest! as URLRequest, completionHandler: getAuthorisationToken)
            task.resume()
            
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        randomString = String.random(length: 50)
        urlRequest = setupCodeRequestUrl()
        webView.load(urlRequest! as URLRequest)
    }
    
    func setupCodeRequestUrl() -> NSMutableURLRequest? {
        print("setup code request")
        let queryItems = [
            NSURLQueryItem(name: "client_id", value: CLIENT_ID),
            NSURLQueryItem(name: "redirect_uri", value: "http://127.0.0.1"),
            NSURLQueryItem(name: "scope", value: "public forum"),
            NSURLQueryItem(name: "state", value: randomString),
            NSURLQueryItem(name: "response_type", value: "code")
        ]
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/oauth/authorize"
        urlComponents.queryItems = queryItems as [URLQueryItem]
        let urlRequest = NSMutableURLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    
    func setupAccessTokenURL(code: String) -> NSMutableURLRequest? {
        let queryItems = [
            NSURLQueryItem(name: "grant_type", value: "authorization_code"),
            NSURLQueryItem(name: "client_secret", value: SECRET_ID),
            NSURLQueryItem(name: "client_id", value: CLIENT_ID),
            NSURLQueryItem(name: "redirect_uri", value: "http://127.0.0.1"),
            NSURLQueryItem(name: "state", value: randomString),
            NSURLQueryItem(name: "code", value: code),
        ]
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.intra.42.fr"
        urlComponents.path = "/oauth/token"
        urlComponents.queryItems = queryItems as [URLQueryItem]
        let urlRequest = NSMutableURLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    
    func getAuthorisationToken(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if let err = error {
            print(err)
            return
        }
        if let d = data {
            do {
                let dic = try JSONDecoder().decode(Access.self, from: d)
                token = dic.access_token
            }
            catch (let err) {
                print(err)
            }
        }
    }
}


