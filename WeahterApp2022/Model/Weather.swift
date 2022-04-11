//
//  Weather.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/2/22.
//

import Foundation

struct Weather: Decodable {
    var lat: Double
    var lon: Double
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Decodable {
    var temp: Double
}

struct Hourly: Decodable {
    var dt: Int
    var temp: Double
    var pressure: Int
    var uvi: Double
    var wind_gust: Double
    var weather: [weather]
}

struct Daily: Decodable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Temp
    var weather: [weather]
}

struct Temp: Decodable {
    var day: Double
}

struct weather: Decodable {
    var description: String
    var id: Double
    var main: String
}




