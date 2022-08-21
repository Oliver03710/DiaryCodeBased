//
//  FetchImages.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/21.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class FetchImageManager {
    
    private init() { }
    
    static let shared = FetchImageManager()
    
    typealias completionHandler = ([String]) -> Void
    
    func fetchImages(query: String, completionHandler: @escaping completionHandler) {
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = "\(Endpoints.unsplashURL)?page=1&per_page=100&query=\(text)&client_id=\(APIKeys.unsplashKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let urlArr = json["results"].arrayValue.map { $0["urls"]["small"].stringValue }
                
                completionHandler(urlArr)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}



