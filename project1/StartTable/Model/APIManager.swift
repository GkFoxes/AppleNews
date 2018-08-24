//
//  APIManager.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 30.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

func initialData(completion: ((Result<News>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "newsapi.org"
    urlComponents.path = "/v2/top-headlines"
    
    let countryItem = URLQueryItem(name: "country", value: "ru")
    let apiKeyItem = URLQueryItem(name: "apiKey", value: "aa953c7c330a4f13b3fc1a69c1361892")
    
    urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    urlComponents.queryItems = [countryItem, apiKeyItem]
    
    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    print(url)
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        DispatchQueue.main.async {
            if let error = responseError {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode(News.self, from: jsonData)
                    completion?(.success(posts))
                    //print(response)
                } catch {
                    completion?(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion?(.failure(error))
            }
        }
    }
    task.resume()
}
