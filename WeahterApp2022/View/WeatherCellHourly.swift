//
//  WeatherCellVertical.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/2/22.
//

import Foundation
import UIKit

class WeatherCellHourly: UICollectionViewCell {
    
    let viewModel = WeatherViewModel()
    
    var hourly: Hourly? {
        didSet {
            configureUI()
        }
    }
    
    var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun")
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 28) .isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28) .isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var currentTemp: UILabel = {
        let label = UILabel()
        label.text = "48"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hourTime: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Helpers
    
    func configureUI() {
        
        let stack = UIStackView(arrangedSubviews: [hourTime, weatherIcon, currentTemp])
        stack.spacing = 2
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center

       addSubview(stack)
        stack.topAnchor.constraint(equalTo: topAnchor) .isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor) .isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor) .isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor) .isActive = true
        
        
        guard let hourlyTemp = hourly?.temp else { return }
        let currentTempInt = Int(hourlyTemp)
        currentTemp.text = "\(currentTempInt)"
        
        guard let date = hourly?.dt else { return }
        var hourlyTime = viewModel.getTime(date: Date(timeIntervalSince1970: Double(date)))
        hourTime.text = "\(hourlyTime)"
 
        
        guard let weatherArrayID = hourly?.weather[0] else { return }
        let id = weatherArrayID.id
        print("DEBUG: ID is \(id)")
        let weatherImage = viewModel.getWeatherIcon(id: id)
        weatherIcon.image = weatherImage
        
        
        
        
    }
}
