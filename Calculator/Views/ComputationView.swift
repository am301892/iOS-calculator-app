//
//  ComputationView.swift
//  Calculator
//
//  Created by Aleksandra Maksimowska
//

import SwiftUI

struct ComputationView: View {
    let currentComputation: String
    let mainResult: String
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Spacer()
                Text(currentComputation)
                    .foregroundColor(foregroundDigitsColor)
                    .font(UIDevice .isIPad ? .largeTitle : .body)
                .lineLimit(1)
            }
            .minimumScaleFactor(0.1)
            
            HStack {
                Spacer()
                Text(mainResult)
                    .foregroundColor(foregroundDigitsColor)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                .lineLimit(1)
            }
            .minimumScaleFactor(0.1)
        }.padding(.horizontal)
    }
}

#Preview {
    VStack {
        ComputationView(currentComputation: "5+1", mainResult: "6")
    }
}
