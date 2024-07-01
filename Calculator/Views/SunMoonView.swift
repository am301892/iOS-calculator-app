//
//  SunMoonView.swift
//  Calculator
//
//  Created by Aleksandra Maksimowska 
//

import SwiftUI

struct SunMoonView: View {
    var lightMode: Bool
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "sun.min")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonSelectedColor : sunOrMoonNotSelectedColor)
                .font(UIDevice.isIPad ? .title : .body)
                .fontWeight(UIDevice.isIPad ? .semibold : .regular)
            
            Image(systemName: "moon")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonNotSelectedColor : sunOrMoonSelectedColor)
                .font(UIDevice.isIPad ? .title : .body)
                .fontWeight(UIDevice.isIPad ? .semibold : .regular)
        }.padding()
            .background(secondaryBackgroundColor)
            .cornerRadius(20)
//            .font(.title)
//            .fontWeight(.semibold)
    }
}

struct SunMoonView_Previews: PreviewProvider{
    static var previews: some View {
        VStack{
            SunMoonView(lightMode: true)
            SunMoonView(lightMode: false)
        }
    }
}
