//
//  Api_UploadFiles.swift
//  GoLawUser
//
//  Created by rania refaat on 4/9/21.
//

//import Alamofire
//
//extension Manager {
//    
//    func performFiles<T: Codable>(_ decoderr: T.Type , serviceName: ServiceName ,method: HTTPMethod , getWithParams: Bool = false, files: [FileData],  arguments: String? = nil,  authenticationEnabled: Bool = false , parameters: [String : Any]?  = nil , completion: @escaping (ServerResponse<T>) -> Void){
//        
//        //        @escaping (Any?, String?) -> Void) -> Void
//        
//        let url: String = "\(BaseURL.staging.rawValue)\(serviceName.rawValue)"
//        
//        var urlString = url
//        
//        var params: [String: Any]? = parameters
//        
//        // URL With Arguments
//        
//        if let args = arguments {
//            urlString = "\(urlString)/\(args)"
//        }
//        // Method Type Get With Parameters (Must be a [String: Strin])
//        if getWithParams {
//            
//            if let stringParams = parameters as? [String: String] {
//                if stringParams.count > 0 {
//                    
//                    urlString = "\(urlString)?"
//                    
//                    for (index, item) in stringParams.enumerated() {
//                        
//                        urlString.append(item.key)
//                        urlString.append("=")
//                        urlString.append(item.value)
//                        
//                        let lastIndex = (stringParams.count-1)
//                        if index != lastIndex {
//                            urlString.append("&")
//                        }
//                        
//                    }
//                }
//            }
//            params = nil
//            
//        }
//        
//        urlString = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
//        
//        print("URL: \(urlString)")
//        print("ServiceName:\(serviceName)  parameters: \(params ?? [:]))")
//        
//        var lang : String = "ar"
//        
//        if L102Language.currentAppleLanguage() == arabicLang {
//            lang = "ar"
//        }else{
//            lang = "en"
//        }
//        
//        var headers: HTTPHeaders = ["Accept": "application/json",
//                                    "X-Requested-With": "XMLHttpRequest",
//                                    "X-localization":  lang]
//        
//        let userToken = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.userToken)
//        
//        if authenticationEnabled && userToken != nil {
//            //            headers["Authorization"] = "Bearer " + (userToken ?? "")
//            headers["Authorization"] =  (userToken ?? "")
//            
//        }
//        print("Headers: \(headers)")
//        let decoder = JSONDecoder()
//        
//        AF.upload(multipartFormData: { multipartFormData in
//            
//            for i in files {
//                if i.fileType == "image"{
//                    if let imgData = i.fileImage?.jpegData(compressionQuality: 0.3){
//                        print("imgData\(imgData)")
//                        multipartFormData.append(imgData, withName: "files[]",fileName: "image.jpg", mimeType: "image/jpg")
//                    }
//                }else if i.fileType == "pdf" {
//                    let pdfData = try! Data(contentsOf: i.fileUrl.asURL())
//                    
//                    multipartFormData.append(pdfData, withName: "files[]", fileName: "file.pdf", mimeType:"application/pdf")
//                    
//                }else if i.fileType == "audio"{
//                    let audioData = try! Data(contentsOf: i.fileUrl.asURL())
//
//                    multipartFormData.append(audioData,withName: "files[]" , fileName: "audio.m4a")
//                }
//            }
//            for (key, value) in parameters! {
//                print("valueee \(value) for key\(key)")
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//            } //Optional for extra parameters
//        },to: urlString , method: method , headers: headers).responseData { (response) in
//            let responseValue = response.result
//            print("responseValue\(responseValue)")
//            
//            switch response.result {
//            case .success(let value):
//                print(String(data: value, encoding: .utf8)!)
//                do {
//                    let decodert = JSONDecoder()
//                    let modules = try decodert.decode(decoderr, from: value)
//                    completion(ServerResponse<T>.success(modules) )
//                }catch {
//                    print("catch >>>>")
//                    completion(ServerResponse<T>.failure(error) )
//                }
//            case .failure(let error):
//                print(error)
//                completion(ServerResponse<T>.noConnection("There Is No Connection".localize))
//            }//end of alamofire
//        }//end of imgData
//        
//    }//end of class function
//}//end of extension
//
//
