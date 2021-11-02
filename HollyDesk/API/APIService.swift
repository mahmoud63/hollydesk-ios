//
//  APIService.swift
//  Alothim
//
//  Created by apple on 10/20/19.
//  Copyright © 2019 panorama. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Manager {
    
    
    func perform<T: Codable>(_ decoder: T.Type , serviceName: ServiceName ,method: HTTPMethod , getWithParams: Bool = false,  arguments: String? = nil,  authenticationEnabled: Bool = false , parameters: [String : Any]?  = nil , completion: @escaping (ServerResponse<T>) -> Void){
            
        let url: String = "\(BaseURL.staging.rawValue)\(serviceName.rawValue)"
        
        var urlString = url

        var params: [String: Any]? = parameters
        
        // URL With Arguments
        
        if let args = arguments {
            urlString = "\(urlString)/\(args)"
        }
        // Method Type Get With Parameters (Must be a [String: Strin])
        if getWithParams {
            
            if let stringParams = parameters as? [String: String] {
                if stringParams.count > 0 {
                    
                    urlString = "\(urlString)?"
                    
                    for (index, item) in stringParams.enumerated() {
                        
                        urlString.append(item.key)
                        urlString.append("=")
                        urlString.append(item.value)
                        
                        let lastIndex = (stringParams.count-1)
                        if index != lastIndex {
                            urlString.append("&")
                        }
                        
                    }
                }
            }
            params = nil
            
        }

        urlString = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
         
        print("URL: \(urlString)")
        print("ServiceName:\(serviceName)  parameters: \(params ?? [:]))")
        
        var lang : String = "ar"
        
        if L102Language.currentAppleLanguage() == arabicLang {
            lang = "ar"
        }else{
            lang = "en"
        }

        var headers: HTTPHeaders = []
        let userToken = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.userToken)
        
        if authenticationEnabled && userToken != nil {
//            headers["Authorization"] = "Bearer " + (userToken ?? "")
            headers["x-auth-token"] =  (userToken ?? "")
        }
        headers["Accept"] = "application/json"

        print("Headers: \(headers)")

        AF.request(urlString,method: method , parameters: params , headers: headers ).responseData { (response) in
            let responseValue = response.result
            switch response.result {
            case .success(let value):
                do {
                    let json = try JSON(data: value)
                    print(json)
                }catch {
                }
                do {
                    let JsonDecoder = JSONDecoder()
                    let modules = try JsonDecoder.decode(decoder, from: value)
                    completion(ServerResponse<T>.success(modules) )
                }catch {
                    print("catch >>>>")
                    print(error)
                    completion(ServerResponse<T>.failure(error) )
                }
            case .failure(let error):
                print(error)
                
                completion(ServerResponse<T>.noConnection("There Is No Connection".localize))
                
            }
            
        }//end of alamofire
    }//end of class function
     
}//end of class
enum ServerResponse<T> {
    case success(T), failure(Error?) , noConnection(String?)
}
let arabicLang = "ar"
let englishLang = "en"
