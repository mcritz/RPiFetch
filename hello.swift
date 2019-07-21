#!/usr/bin/env swift

import Foundation

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

struct CurrentWeather: Codable {
    let time: Int
    let summary: String
    let icon: String
    let nearestStormDistance: Int
    let nearestStormBearing: Int
    let percipIntensity: Int
    let precipProbability: Int
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Int
    let ozone: Double
}

struct DarkSkyResponse: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let offset: Int
    let currentWeather: CurrentWeather
}

guard let jsonData = contents.data(using: .utf8) else {
    print(contents)
    fatalError("Could not convert response to data")
}

let decoder = JSONDecoder()

if let response: DarkSkyResponse = decoder.decode(DarkSkyResponse.self, from: jsonData) 

print("completed decode")
print(response)
print("\(response?.currentWeather.temperature)")







