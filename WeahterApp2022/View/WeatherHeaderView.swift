//
//  WeatherHeaderView.swift
//  WeahterApp2022
//
//  Created by Brandon Dowless on 4/8/22.
//

import Foundation
import UIKit


class WeatherHeaderView: UIView {
    
    
    var city: UILabel = {
        let label = UILabel()
        label.text = "Gaithersburg"
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
        addSubview(city)
        city.centerXAnchor.constraint(equalTo: centerXAnchor) .isActive = true
        city.centerYAnchor.constraint(equalTo: centerYAnchor) .isActive = true
    }
}
