//
//  API_Image.swift
//  Alothim
//
//  Created by apple on 10/21/19.
//  Copyright © 2019 panorama. All rights reserved.
//

import Alamofire

extension Manager {
    
    func performImages<T: Codable>(_ decoderr: T.Type , serviceName: ServiceName ,method: HTTPMethod , getWithParams: Bool = false, image: UIImage? = nil,  arguments: String? = nil,  authenticationEnabled: Bool = false ,imageName: String , parameters: [String : Any]?  = nil , completion: @escaping (ServerResponse<T>) -> Void){
        
        //        @escaping (Any?, String?) -> Void) -> Void
        
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

        var headers: HTTPHeaders = ["Accept": "application/json"]
        
        let userToken = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.userToken)
        
        if authenticationEnabled && userToken != nil {
//            headers["Authorization"] = "Bearer " + (userToken ?? "")
            headers["x-auth-token"] =  (userToken ?? "")
        }
        
        print("Headers: \(headers)")
        let decoder = JSONDecoder()
        if let img = image {
            if let imgData = img.jpegData(compressionQuality: 0.3){
                print("imgData\(imgData)")
                
                AF.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(imgData, withName: imageName,fileName: "image.jpg", mimeType: "image/jpg")
                    
                    guard let parm = parameters else {
                        return
                    }
                    for (key, value) in parm {
                        print("valueee \(value) for key\(key)")
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    } //Optional for extra parameters
                },to: urlString , method: method , headers: headers).responseData { (response) in
                    let responseValue = response.result
                    print("responseValue\(responseValue)")
                    
                    switch response.result {
                    case .success(let value):
                        print(String(data: value, encoding: .utf8)!)
                        do {
                            let decodert = JSONDecoder()
                            let modules = try decodert.decode(decoderr, from: value)
                            completion(ServerResponse<T>.success(modules) )
                        }catch {
                            print("catch >>>>")
                            completion(ServerResponse<T>.failure(error) )
                        }
                    case .failure(let error):
                        print(error)
                        completion(ServerResponse<T>.noConnection("There Is No Connection".localize))
                        
                    }
                }
            }//end of alamofire
        }//end of imgData
        
    }//end of class function
}//end of extension


