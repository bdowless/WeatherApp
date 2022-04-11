//
//  WeatherViewModel.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/8/22.
//

import Foundation
import UIKit

struct WeatherViewModel {

    func calculateWeatherIcon(weatherIcon: UIImageView, temp: Double) {
        if temp <= 60 {
            weatherIcon.image = UIImage(systemName: "cloud.rain.fill")
        }
        else if temp <= 70 {
            weatherIcon.image = UIImage(systemName: "cloud.sun.bolt")
        }
        else {
            weatherIcon.image = UIImage(systemName: "sun.max.fill")
        }
    }
    
    func getWeatherIcon(id: Double) -> UIImage? {
        switch id {
        case 200...232:
            return UIImage(systemName: "cloud.bolt.rain")
        case 300...321:
            return UIImage(systemName: "cloud.drizzle")
        case 500...531:
            return UIImage(systemName: "cloud.heavyrain")
        case 600...622:
            return UIImage(systemName: "cloud.snow")
        case 700...781:
            return UIImage(systemName: "smoke.fill")
        case 800:
            return UIImage(systemName: "sun.max")
        default:
            return UIImage(systemName: "sun.max.circle")
        }
    }
    
    func dailyWeatherIcon(description: String) -> UIImage? {
        if description.contains("thunder") {
            return UIImage(systemName: "cloud.bolt.rain")
        }
        else if description.contains("drizzle") {
            return UIImage(systemName: "cloud.drizzle")
        }
        else if description.contains("snow") {
            return UIImage(systemName: "cloud.snow")
        }
        else if description.contains("light rain") {
            return UIImage(systemName: "cloud.heavyrain")
        }
        else if description.contains("clear") {
            return UIImage(systemName: "sun.max")
        }
        else {
        return UIImage(systemName: "sun.max.circle")
        }
    }

    func getDate( date: Date?) -> String {
        guard let inputDate = date else { return ""}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: inputDate)
    }
    
    func getTime( date: Date?) -> String {
        guard let inputDate = date else { return ""}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: inputDate)
    }
}
