//
//  WeatherCellHorizontal.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/2/22.
//

import Foundation
import UIKit

class WeatherCellHorizontal: UITableViewCell {
    
    let viewModel = WeatherViewModel()
    
    var daily: Daily? {
        didSet {
            configureUI()
        }
    }
    
    
    var temp: UILabel = {
        let label = UILabel()
        label.text = "Testing"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherDescription: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.haze.fill")
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.widthAnchor.constraint(equalToConstant: 40) .isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var date: UILabel = {
        let label = createUILabel()
        return label
    }()
    
    var thermometerIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "thermometer.sun.fill")
        image.tintColor = .systemOrange
        image.contentMode = .scaleAspectFill
        image.widthAnchor.constraint(equalToConstant: 28) .isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Helpers
    
    func configureUI() {
        guard let daily = daily else { return }
        
        let stack = UIStackView(arrangedSubviews: [date, weatherIcon, temp, thermometerIcon])
        stack.axis = .horizontal
        stack.spacing = 30
        stack.contentMode = .scaleAspectFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20) .isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 30) .isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20) .isActive = true
        
        let temperature = Int(daily.temp.day)
        temp.text = "\(temperature) F°"
        weatherDescription.text = daily.weather.description
        

        viewModel.calculateWeatherIcon(weatherIcon: weatherIcon, temp: daily.temp.day)
        
        
        date.text = viewModel.getDate(date: Date(timeIntervalSince1970: Double(daily.dt)))
        
        
        let weatherArrayID = daily.weather[0]
        let id = weatherArrayID.id
        let weatherImage = viewModel.getWeatherIcon(id: id)
        weatherIcon.image = weatherImage
        
        print("DEBUG: WEATHER ARRAY IS \(id)")
    
        
    }
}

extension UILabel {
    func newLabel() {
        let label = UILabel()
        label.text = "Testing"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}

func createUILabel() -> UILabel {
    let label = UILabel()
    label.text = "Testing"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}



