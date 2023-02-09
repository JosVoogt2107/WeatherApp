//
//  CitySearch.swift
//  WeatherApp
//
//  Created by Jos Voogt on 09/02/2023.
//

import SwiftUI

struct CitySearch: View {
    
    @Binding var city: String
    
    var image = "Cloud"
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .center) {
                Text("Type een Plaats in")
                TextField("plaats", text: $city)
                    .frame(width: 200)
            }
            .padding(.all)
              
                
        }
    }
}

struct CitySearch_Previews: PreviewProvider {
    static var previews: some View {
        CitySearch(city: .constant(""))
    }
}
