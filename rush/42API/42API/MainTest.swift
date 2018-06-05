//
//  MainTest.swift
//  42API
//
//  Created by Stephane MARTINS on 6/2/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import Foundation

var urlAccess = NSURL(string: "https://api.intra.42.fr/oauth/token")
var accessRequest = NSMutableURLRequest(url: urlAccess! as URL)
let CLIENT_ID = "5f59be975ba4534b0832ce23924a7ccdb18181cb67e391e89aca4d44cad849ca"
let SECRET_ID = "972ffb67fc62278f14f536992af486cb22b504125c50941047aef1fbc5eac969"
let BEARER = ((CLIENT_ID + ":" + SECRET_ID).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))


func setupAccessRequest() {
    accessRequest.httpMethod = "POST"
    accessRequest.setValue("Basic " + BEARER , forHTTPHeaderField: "Authorization")
    accessRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
    accessRequest.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
}


func getAuthorisationToken(data: Data?, urlResponse: URLResponse?, error: Error?) {
    if let err = error {
        print(err)
        return
    }
    if let d = data {
        do {
            print("entre dans le doo")
            
            if let dic = String(data: d, encoding: .utf8) {
                print(dic)
            }
        }
        catch (let err) {
            print(err)
        }
    }
}
