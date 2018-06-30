//
//  CurrentWeather.swift
//  project1
//
//  Created by Дмитрий Матвеенко on 30.06.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    //let icon: UIImage
}

extension CurrentWeather: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
            let apparentTemperature = JSON["apparentTemperature"] as? Double,
            let humidity = JSON["humidity"] as? Double,
            //let iconString = JSON["icon"] as? String
            let pressure = JSON["pressure"] as? Double else {
                return nil
        }
        
        //let icon = WeatherIconManager(rawValue: iconString).image
        
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        //self.icon = icon
        
    }
}


extension CurrentWeather {
    var pressureString: String {
        return "\(Int(pressure * 0.750062)) mm"
    }
    
    var humidityString: String {
        return "\(Int(humidity * 100)) %"
    }
    
    var temperatureString: String {
        return "\(Int(5 / 9 * (temperature - 32)))˚C"
    }
    
    var appearentTemperatureString: String {
        return "Feels like: \(Int(5 / 9 * (apparentTemperature - 32)))˚C"
    }
}

enum WeatherIconManager: String {
    
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    case UnpredictedIcon = "unpredicted-icon"
    
    init(rawValue: String) {
        switch rawValue {
        case "clear-day": self = .ClearDay
        case "clear-night": self = .ClearNight
        case "rain": self = .Rain
        case "snow": self = .Snow
        case "sleet": self = .Sleet
        case "wind": self = .Wind
        case "fog": self = .Fog
        case "cloudy": self = .Cloudy
        case "partly-cloudy-day": self = .PartlyCloudyDay
        case "partly-cloudy-night": self = .PartlyCloudyNight
        default: self = .UnpredictedIcon
            
        }
    }
}

extension WeatherIconManager {
    //    var image: UIImage {
    //        return UIImage(named: self.rawValue)!
    //    }
}

// MARK: - Add Data from Weather API

extension StartTableViewController {
    
    func fetchCurrentWeatherData(){
        for tenCoordinates in coordinates{
            weatherManager.fetchCurrentWeatherWith(coordinates: tenCoordinates) { (result) in
                //self.toggleActivityIndicator(on: false)
                
                switch result {
                case .Success(let currentWeather):
                    self.updateUIWith(currentWeather: currentWeather, coordinates: tenCoordinates)
                case .Failure(let error as NSError):
                    
                    let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                default: break
                }
            }
        }
    }
    
    func updateUIWith(currentWeather: CurrentWeather, coordinates: Coordinates ) {
        let girlItem = Girl()
        girlItem.name = coordinates.name
        girlItem.biography = currentWeather.pressureString
        girlItem.link = currentWeather.appearentTemperatureString
        
        try! realm.write({
            realm.add(girlItem)
        })
        
        tableContent.reloadData()
        
        //UserDefaults.standard.set(true, forKey: "db_install")
        //        self.imageView.image = currentWeather.icon
        //        self.pressureLabel.text = currentWeather.pressureString
        //        self.temperatureLabel.text = currentWeather.temperatureString
        //        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        //        self.humidityLabel.text = currentWeather.humidityString
    }
}
