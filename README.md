# CityWeather
Coding assignment for seeing weather data for specified cities.

# Description
This project is intended to be the coding exam for SimplePractice. 
- Language: SwiftUI
- Architecture: MVVM

## Key Notes
- The “GooglePlaces” pod did not appear to be written out for friendly use with SwiftUI, so I ended up creating this functionality natively.
- The "Hourly" call for openweathermap was behind a paywall, so I used the 5 day forecase call instead.
- In order to fulfill the requirement of working with Cocoapods, I integrated the lottie-ios pod to spice up the Forecast detail screen.

## Requirements: 

Forecast Screen
1. Have two tabs for “Current” and “Hourly” forecast by city
2. Display a list of a cities with a brief summary (temperature, conditions) about weather
3. Have a button in the top right corner of the screen which navigates to a “List of Cities”
screen
4. Open “Detailed Forecast” screen on cell tap
5. Implement swipe-to-refresh feature
6. Fetch new data every time app starts

Forecast detail Screen
1. Use your imagination skills to present the weather for one specific city

List of Cities Screen
1. Display a list of a cities with names
2. Have a button in the top right corner of the screen which navigates to an “Add City”
screen
3. Implement swipe-to-delete feature which should delete a city from the list and clear its
data from a data storage

Add City Screen
1. The screen should be presented modally
2. Display a search bar at the top of the screen
3. Use Google Places SDK (pod “GooglePlaces”) to implement an autocomplete search
4. Display a list of cities according to a current search query

# Getting Started
## Dependencies
Cocoapods 

# Installing
CityWeather master branch
