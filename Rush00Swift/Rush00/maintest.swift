//
//import Foundation
//
//var urlAccess = NSURL(string: "https://api.intra.42.fr/oauth/token")
//var accessRequest = NSMutableURLRequest(url: urlAccess! as URL)
//let CLIENT_ID = "5f59be975ba4534b0832ce23924a7ccdb18181cb67e391e89aca4d44cad849ca"
//let SECRET_ID = "972ffb67fc62278f14f536992af486cb22b504125c50941047aef1fbc5eac969"
//let BEARER = ((CLIENT_ID + ":" + SECRET_ID).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//
//
//func setupAccessRequest() {
//    accessRequest.httpMethod = "POST"
//    accessRequest.setValue("Basic " + BEARER , forHTTPHeaderField: "Authorization")
//    accessRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//    accessRequest.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//}
//
//
//
//func getAuthorisationToken(data: Data?, urlResponse: URLResponse?, error: Error?) {
//    if let err = error {
//        print(err)
//        return
//    }
//    if let d = data {
//        do {
//            if let dic = String(data: d, encoding: .utf8) {
//                print(dic)
//            }
//        }
//        catch (let err) {
//            print(err)
//        }
//    }
//}
//
//
//
//setupAccessRequest()
//var task  = URLSession.shared.dataTask(with: accessRequest as URLRequest, completionHandler: getAuthorisationToken)
//task.resume()
//while(true) {}
//
//
//
////
//
//https://api.intra.42.fr/oauth/authorize?client_id=your_very_long_client_id&redirect_uri=http%3A%2F%2Flocalhost%3A1919%2Fusers%2Fauth%2Fft%2Fcallback&response_type=code&scope=public&state=a_very_long_random_string_witchmust_be_unguessable'
//
//
//curl -F grant_type=authorization_code \
//-F client_id=5f59be975ba4534b0832ce23924a7ccdb18181cb67e391e89aca4d44cad849ca \
//-F code=9b54dbc3d72a14aa66f1e29ce9eb1c1a2046cefd905bf77628664324028b55c4 \
//-F response_type=code \
//-F scope=scope=public%20forum \
//-F state=Hw4exVg6GK8Wof7Qz5r4jYfoynY4vAYKFKSzYMMvW0RfnMsqXL \
//-F redirect_uri=http://127.0.0.1 \
//-X POST https://api.intra.42.fr/oauth/authorize
//
//curl -F grant_type=authorization_code \
//-F client_id=5f59be975ba4534b0832ce23924a7ccdb18181cb67e391e89aca4d44cad849ca \
//-F client_secret=972ffb67fc62278f14f536992af486cb22b504125c50941047aef1fbc5eac969 \
//-F code=9b54dbc3d72a14aa66f1e29ce9eb1c1a2046cefd905bf77628664324028b55c4 \
//-F redirect_uri=http://127.0.0.1 \
//-X POST https://api.intra.42.fr/oauth/token
////
////
//curl -X POST --data "grant_type=client_credentials&client_id=MY_AWESOME_UID&client_secret=MY_AWESOME_SECRET" https://api.intra.42.fr/oauth/token

//{
//    "id":87073,
//    "author":{
//        "id":21388,
//        "login":"clanier",
//        "url":"https://api.intra.42.fr/v2/users/clanier"
//    },
//    "content":"### y a deund by mdalil\u003cspan data-watch-id=\"7945\" class=\"badge\"\u003e33\u003c/span\u003e\u003c/a\u003e\u003c/li\u003e\u0026#x000A;\u003c/ul\u003e\u0026#x000A;\u0026#x000A;\u003cp\u003e\u003cimg src=\"https://i.imgur.com/0kmdhG1.png\" alt=\"\"\u003e\u003c/p\u003e",
//    "replies":[
//    
//    ],
//    "created_at":"2018-03-17T21:45:45.873Z",
//    "updated_at":"2018-05-16T21:41:00.816Z",
//    "parent_id":null,
//    "is_root":true,
//    "messageable_id":18557,
//    "messageable_type":"Topic",
//    "votes_count":{
//        "upvote":118,
//        "downvote":2,
//        "trollvote":0,
//        "problem":0
//    },
//    "user_votes":{
//        "upvote":false,
//        "downvote":false,
//        "trollvote":false,
//        "problem":false
//    },
//    "readings":1
//},
//
