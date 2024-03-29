//
//  DailyPu.swift
//  
//
//  Created by Michael Critz on 7/21/19.
//

import Foundation
import PythonKit

struct CurrentWeather: Codable {
    let time: Int?
    let summary: String
//    let nearestStormDistance: Int?
//    let nearestStormBearing: Int?
//    let precipIntensity: Int?
//    let precipProbability: Int?
    let temperature: Double
//    let apparentTemperature: Double?
//    let dewPoint: Double?
//    let humidity: Double?
//    let pressure: Double?
//    let windSpeed: Double?
//    let windGust: Double?
//    let windBearing: Int?
//    let cloudCover: Double?
//    let uvIndex: Int?
//    let visibility: Double?
//    let ozone: Double?
}

struct DarkSkyResponse: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let offset: Int
    let currently: CurrentWeather
}

class FileService {
    static func write(text: String, to filename: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(filename)
            
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                fatalError("Could not save file")
            }
        }

    }
}

class NetworkService {
    static func getWeather() -> String {
        print("Daily Pi! Powered by DarkSky")
        
        guard let wxApiKey = ProcessInfo.processInfo.environment["DARKSKYAPIKEY"] else {
            fatalError("Must set DARKSKYAPIKEY environment variable. Get an API key at https://darksky.net/poweredby")
        }

        guard let url = URL(string: "https://api.darksky.net/forecast/\(wxApiKey)/37.8267,-122.4233?exclude=minutely,hourly,daily,alerts,flags") else {
            fatalError("Could not create a valid url for \(wxApiKey)")
        }
        
        guard let contents = try? String(contentsOf: url) else {
            fatalError("Could not load weather data")
        }
        print(contents)
        guard let jsonData = contents.data(using: .utf8) else {
            print(contents)
            fatalError("Could not convert response to data")
        }
        
        let response = try? JSONDecoder().decode(DarkSkyResponse.self, from: jsonData)
        
        print("completed decode")
        print(response ?? "failed to respond")
        
        var currentWX = ""
        
        if let response = response {
            print(response.currently)
            
            currentWX = "\(response.currently.summary)\n\(response.currently.temperature)F"
            print(currentWX)
        }
        return currentWX
    }
}

func main() {
    let message = NetworkService.getWeather()
    
    FileService.write(text: message, to: "current-wx.txt")
    exit(0)
}

main()
