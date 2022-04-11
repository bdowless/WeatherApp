//
//  FetchWeatherData.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/2/22.
//

import Foundation

struct WeatherAPI {
    func weatherAPI(long: Double, lat: Double, completion: @escaping([Daily]) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=02c0af83e038bf25864c5c0a195c0e9c&units=imperial"

        guard let url = URL(string: url) else { return }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { Data, Response, Error in
            guard let data = Data else { return }
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                print("DEBUG: data is \(weatherData)")
                let DailyData = weatherData.daily
                DispatchQueue.main.async {
                    completion(DailyData)
                }

            }

            catch let decodeError {
                print("DEBUG: we have an \(decodeError)")
            }
    
        }
        task.resume()
    }
    
    func hourlyWeatherAPI(lat: Double, long: Double, completion: @escaping([Hourly]) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=02c0af83e038bf25864c5c0a195c0e9c&units=imperial"

        guard let url = URL(string: url) else { return }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { Data, Response, Error in
            guard let data = Data else { return }
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                print("DEBUG: data is \(weatherData)")
                let DailyData = weatherData.hourly
                DispatchQueue.main.async {
                    completion(DailyData)
                }

            }

            catch let decodeError {
                print("DEBUG: we have an \(decodeError)")
            }
    
        }
        task.resume()
    }
    
    func dailyWeatherId(lat: Double, long: Double, completion: @escaping([weather]) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=02c0af83e038bf25864c5c0a195c0e9c&units=imperial"

        guard let url = URL(string: url) else { return }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { Data, Response, Error in
            guard let data = Data else { return }
            
            do {
                let weatherData = try JSONDecoder().decode(Daily.self, from: data)
                print("DEBUG: data is \(weatherData)")
                let dailyData = weatherData.weather
                DispatchQueue.main.async {
                    completion(dailyData)
                }

            }

            catch let decodeError {
                print("DEBUG: we have an \(decodeError)")
            }
    
        }
        task.resume()
    }
}

