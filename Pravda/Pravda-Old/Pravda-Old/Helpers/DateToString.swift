//
//  DateToString.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 23/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class DateToString {
    static func formatDateNews(_ dateString: String?) -> String? {
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "HH:mm"
        
        guard let preDate = dateString, let date = dateFormatter.date(from: preDate) else { return nil }
        let finalString = newFormat.string(from: date)
        
        return finalString
    }
    
    static func formatDateFavoriteNews(_ dateString: String?) -> String? {
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newFormat = DateFormatter()
        newFormat.dateFormat = "MM-dd HH:mm"
        
        guard let preDate = dateString, let date = dateFormatter.date(from: preDate) else { return nil }
        let finalString = newFormat.string(from: date)
        
        return finalString
    }
}
