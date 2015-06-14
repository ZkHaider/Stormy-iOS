//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Haider Khan on 6/13/15.
//  Copyright (c) 2015 ZkHaider. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    var temperature: Int?
    var humidity: Int?
    var precipProbability: Int?
    var summary: String?
    
    init(weatherDictionary: [String: AnyObject]) {
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipProbabilityFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbability = Int(precipProbabilityFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = weatherDictionary["summary"] as? String
    }
}