//
//  DetailNewsViewModelType.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 18/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

protocol NewsDetailViewModelType {
    var title: String? { get }
    var detailText: String? { get }
    var author: String? { get }
    var link: String? { get }
    var photoString: String? { get }
    var imageCache: NSCache<AnyObject, UIImage> { get }
    
    func getPhoto(toImageView imageView: UIImageView, withImageBlur imageBlur: UIImageView, activityIndicator: UIActivityIndicatorView, completion: @escaping(UIImage) -> ())
}
