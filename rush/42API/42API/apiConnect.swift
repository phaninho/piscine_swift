//
//  main.swift
//  42API
//
//  Created by Stephane MARTINS on 6/2/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import Foundation

func start()
{
    var urlAccess = NSURL(string: "https://api.intra.42.fr/oauth/token")
    var accessRequest = NSMutableURLRequest(url: urlAccess! as URL)
    let CLIENT_ID = "9c76fd905ec92e9d2a9c360b4c8880dac7d877994554a4097f147aa73f2ed2f4"
    let SECRET_ID = "a9df6f7336c0cefeba0fb534cd954303a6cff661c9ef9625b9ad8708e06998f5"
    let BEARER = ((CLIENT_ID + ":" + SECRET_ID).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))


    func setupAccessRequest() {
        accessRequest.httpMethod = "POST"
        accessRequest.setValue("Basic " + BEARER , forHTTPHeaderField: "Authorization")
        accessRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        accessRequest.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
    }



    func getAuthorisationToken(data: Data?, urlResponse: URLResponse?, error: Error?)
    {
        if let err = error {
            print(err)
            return
        }
        if let d = data {
            do {
                if let dic = String(data: d, encoding: .utf8) {
                    print(dic)
                }
            }
            catch (let _)
            {
                print("error")
            }
        }
    }



    setupAccessRequest()
    let task  = URLSession.shared.dataTask(with: accessRequest as URLRequest, completionHandler: getAuthorisationToken)
    task.resume()

}
