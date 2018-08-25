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
    
    var category: String? = nil
    for item in categories {
        if (item.id != 0) && (item.isChoise == true) {
            category = item.nameAPI
            break
        } else {
            category = nil
        }
    }
    let categoryItem = URLQueryItem(name: "category", value: category)
    
    urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    
    if category != nil {
        urlComponents.queryItems = [countryItem, apiKeyItem, categoryItem]
    } else {
        urlComponents.queryItems = [countryItem, apiKeyItem]
    }
    
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

func loadNextPage(completion: ((Result<News>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "newsapi.org"
    urlComponents.path = "/v2/top-headlines"
    
    let countryItem = URLQueryItem(name: "country", value: "ru")
    let apiKeyItem = URLQueryItem(name: "apiKey", value: "aa953c7c330a4f13b3fc1a69c1361892")
    let pageItem = URLQueryItem(name: "page", value: "\(pageSearch)")
    
    urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    urlComponents.queryItems = [countryItem, apiKeyItem, pageItem]
    
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
extension StartDetailViewController {
    func obtainImage(with text: String, completion: @escaping (UIImage) -> ()) {
        if let image = imageCache.object(forKey: text as AnyObject) {
            completion(image)
        } else {
            let request = URLRequest(url: URL(string: photoString)!)
            
            URLSession.shared.dataTask(with: request) { (data, responce, error) in
                guard error == nil else {
                    print("Error: \(String(describing:error?.localizedDescription))")
                    DispatchQueue.main.async {
                        self.imageDetail.image = #imageLiteral(resourceName: "primer")
                        self.imageBlurDetail.image = #imageLiteral(resourceName: "primer")
                    }
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                    imageCache.setObject(image, forKey: text as AnyObject)
                }
                }.resume()
        }
    }
}
