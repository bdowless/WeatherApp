//
//  WeatherController.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/2/22.
//

import Foundation
import UIKit
import CoreLocation

class WeatherController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    let reuseIdentifier = "Cell"
    
    
    var hourlyWeatherArray = [Hourly]() {
        didSet {
            self.hourlyCollectionView.reloadData()
            print("DEBUG: We now have hourly Data \(hourlyWeatherArray)")
            let hourly = hourlyWeatherArray[0]
            let weather = hourly.weather[0]
            weatherDescription.text = weather.description
        }
    }
    
    var weatherArray = [Daily]() {
        didSet {
            self.dailyWeatherTableView.reloadData()
            let currentDay = weatherArray[0]
            let currentTemperature = Int(currentDay.temp.day)
            currentTemp.text = "\(currentTemperature)°"
        }
    }
    
    var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.10)
        cv.layer.cornerRadius = 10
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var city: UILabel = {
        let label = UILabel()
        label.text = "Gaithersburg"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentTemp: UILabel = {
        let label = UILabel()
        label.text = "70"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherDescription: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    let dailyWeatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 220, alpha: 0.10)
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuplocation()
        configureUI()
        self.hourlyCollectionView.register(WeatherCellHourly.self, forCellWithReuseIdentifier: "Cell")
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        self.dailyWeatherTableView.register(WeatherCellHorizontal.self, forCellReuseIdentifier: reuseIdentifier)
        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self
    }
    
    // MARK - Location

    func setuplocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.last
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
         
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print("DEBUG: \(lat) , \(long)")
        
        let weatherModel = WeatherAPI()
        weatherModel.weatherAPI(long: long, lat: lat) { daily in
            self.weatherArray = daily
        }
        
        weatherModel.hourlyWeatherAPI(lat: lat, long: long) { hourly in
            self.hourlyWeatherArray = hourly
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBlue
        
        let stack = UIStackView(arrangedSubviews: [city, currentTemp, weatherDescription])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80) .isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
        
        view.addSubview(hourlyCollectionView)
        hourlyCollectionView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 50) .isActive = true
        hourlyCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20) .isActive = true
        hourlyCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20) .isActive = true
        hourlyCollectionView.heightAnchor.constraint(equalToConstant: 110) .isActive = true
        
        view.addSubview(dailyWeatherTableView)
        dailyWeatherTableView.heightAnchor.constraint(equalToConstant: 400) .isActive = true
        dailyWeatherTableView.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 25) .isActive = true
        dailyWeatherTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20) .isActive = true
        dailyWeatherTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20) .isActive = true
        
    }
}



extension WeatherController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WeatherCellHorizontal
        cell.daily = weatherArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension WeatherController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherCellHourly
        cell.hourly = hourlyWeatherArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 70)
    }
    
}

