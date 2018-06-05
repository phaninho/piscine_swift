//
//  ViewController.swift
//  42API
//
//  Created by Stephane MARTINS on 6/2/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    
    @IBOutlet weak var homeImage: UIImageView!
    
    @IBAction func connectButton(_ sender: Any) {
        print("click")
        start()
        
    }
    
    var webView: WKWebView!
    let CLIENT_ID = "5f59be975ba4534b0832ce23924a7ccdb18181cb67e391e89aca4d44cad849ca"
    let SECRET_ID = "972ffb67fc62278f14f536992af486cb22b504125c50941047aef1fbc5eac969"
    var code: String? {
        didSet {
        }
    }
    let randomString = String.random(length: 50)
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.frame = view.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        disableAutocomplete()
        
        view = webView
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url, let query = url.query else { return }
        if query.range(of: "code=")?.lowerBound.encodedOffset == 0 {
            let codeWithAnd = query.components(separatedBy: "=")[1]
            let code = codeWithAnd.components(separatedBy: "&")[0]
            print("_____________________ CODE ______________________" , code)
            let urlRequest = setupAccessTokenURL(code: code)
            let task  = URLSession.shared.dataTask(with: urlRequest! as URLRequest, completionHandler: getAuthorisationToken)
            task.resume()
            
        }
        
    }
    
    
    let url_key = "https://simplon.co/wp-content/uploads/2015/03/logo-42.jpg"
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageWithURL(urlString: url_key)
        // Do any additional setup after loading the view, typically from a nib.
        let urlRequest = setupCodeRequestUrl()
        webView.load(urlRequest! as URLRequest)
    }
    
    func loadImageWithURL(urlString: String)
    {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data,reponse,error) in
            if error != nil
            {
                print("error")
                return
            }
            DispatchQueue.main.async
                {
                    self.homeImage.image = UIImage(data: data!)!
            }
        }).resume()
    }
    
    func setupCodeRequestUrl() -> NSMutableURLRequest? {
        print("can see you")
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
                print(dic.access_token)
                
            }
            catch (let err) {
                print(err)
            }
        }
    }
    
}
    
//    func APITokenRequest(_ code: String)
//    {
//        let url = "https://api.intra.42.fr/oauth/token"
//        let callbackUrl = "apprushurlequivalent%3A%2F%2Fhost%2Finner"
//
//        let params: String = "?grant_type=authorization_code&client_id=" + key + "&client_secret=" + secret + "&code=" + code + "&redirect_uri=" + callbackUrl
//        let request = NSMutableURLRequest(url: (URL(string : url + params) as! URL))
//        request.httpMethod = "POST"
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            (data, response, error) in
//            if let err = error {
//                print(err)
//            }
//            else if let d = data {
//                do {
//                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! NSDictionary {
//                        //print(json["access_token"]!)
//                        self.token = json["access_token"]! as! String
//                        self.APIUserRequest(json["access_token"]! as! String)
//                    }
//                    DispatchQueue.main.async {
//                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        //                            let innerPage: InnerPageViewController = mainStoryboard.instantiateViewController(withIdentifier: "InnerPageViewController") as! InnerPageViewController
//                        let innerPage: StartNavigationController = mainStoryboard.instantiateViewController(withIdentifier:"StartNavigationController") as! StartNavigationController
//                        
//                        //                            innerPage.token = json["access_token"]! as! String
//                        self.window?.rootViewController = innerPage
//                    }
//                }
//                catch (let err) {
//                    print(err)
//                }
//            }
//        }
//        task.resume()
//    }

//}

