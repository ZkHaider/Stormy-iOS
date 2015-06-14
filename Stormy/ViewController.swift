//
//  ViewController.swift
//  Stormy
//
//  Created by Haider Khan on 6/13/15.
//  Copyright (c) 2015 ZkHaider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentTemperatureLabel: UILabel?
    @IBOutlet var currentHumidityLabel: UILabel?
    @IBOutlet var currentRainLabel: UILabel?
    
    private let forecastAPIKey = "b56f05c742f183188926fec132b60490"
    let coordinates: (lat: Double, long: Double) = (37.8267, -122.423)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinates.lat, long: coordinates.long) {
            (let currently) in
            if let currentWeather = currently {
                // Update the UI using GCD
                dispatch_async(dispatch_get_main_queue()) {
                    
                    // Execute Closure, JSON fetched and coming to main thread
                    if let temperature = currentWeather.temperature {
                        // Always use self inside a closure
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipProbability = currentWeather.precipProbability {
                        self.currentRainLabel?.text = "\(precipProbability)%"
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

