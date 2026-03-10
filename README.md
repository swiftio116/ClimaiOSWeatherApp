# Clima ☀️

Clima is a simple iOS weather application built with **Swift** and **UIKit**.
The app allows users to search weather by city name or get the current weather based on the device location.

## Features

• Search weather by city name
• Get weather using current GPS location
• OpenWeather API integration
• JSON parsing using Codable
• Dynamic UI updates
• Weather condition icons

## Tech Stack

- Swift
- UIKit
- CoreLocation
- URLSession
- JSONDecoder
- MVC Architecture
- Git & GitHub
- Xcode

## How it works

The application sends a network request to the **OpenWeather API**, receives weather data in JSON format, decodes it using `Codable`, and updates the UI with the temperature, weather condition, and city name.

## Project Structure

Clima
│
├── Controller
│   └── WeatherViewController.swift
│
├── Model
│   ├── WeatherModel.swift
│   ├── WeatherData.swift
│   └── WeatherManager.swift
│
├── Resources
│   └── Assets.xcassets
│
├── View
│   └── Main.storyboard
│
└── AppDelegate / SceneDelegate
## Setup

1. Clone the repository

git clone https://github.com/YOUR_USERNAME/Clima.git

2. Open the project in Xcode

3. Add your OpenWeather API key

Example:

let apiKey = "YOUR_API_KEY"

4. Run the project on simulator or device


## Screenshots

<img src="screenshot.png" width="300">

