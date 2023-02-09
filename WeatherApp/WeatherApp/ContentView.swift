//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jos Voogt on 09/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var weatherData: WeatherData?
    @State var city = "Tilburg"

    
    var image = "Cloud"
    var customFont = "Helvetica Neue UltraLight"
    var fontSize = 60.0
    var fontSize2 = 30.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(image)
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    Text(city)
                        .font(.custom(customFont, size: fontSize))

                    Text(getTemperatureString())
                        .font(.custom(customFont, size: fontSize))
                    Spacer()
                    NavigationLink(destination: CitySearch(city: $city)) { Text("Vul een plaats in").font(.custom(customFont, size: fontSize2)).foregroundColor( Color.white)}
                    
                }
            }.onAppear(perform: loadData)
        }
    }
    
    func getTemperatureString() -> String {
        guard let weatherData = weatherData else {
            return "?"
        }
        return "\(weatherData.main.temp) °C"
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=3b7c0bb2df5778f696d6dfc53b6189c9&units=metric") else {
            print("Error: failed to construct a URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            var newWeatherData: WeatherData?
            if let error = error {
                print("Error: Fetch failed: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: failed to get data from URLSession")
                return
            }
            
            do {
                newWeatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
            } catch let error as NSError {
                print("Error: decoding. In domain= \(error.domain), description= \(error.localizedDescription)")
            }
            if newWeatherData == nil {
                print("Error: failed to read or decode data")
                return
            }
            DispatchQueue.main.async {
                self.weatherData = newWeatherData
            }
        }
        task.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
