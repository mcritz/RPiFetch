#!/usr/bin/env swift

import Foundation

print("Daily Pi! Powered by DarkSky")

guard let wxApiKey = ProcessInfo.processInfo.environment["DARKSKYAPIKEY"] else {
    fatalError("Must set DARKSKYAPIKEY environment variable. Get an API key at https://darksky.net/dev")
}


guard let url = URL(string: "https://api.darksky.net/forecast/\(wxApiKey)/37.8267,-122.4233") else {
    fatalError("Could not create a valid url for \(wxApiKey)")
}


guard let contents = try? String(contentsOf: url) else {
    fatalError("Could not load weather data")
}

print(contents)