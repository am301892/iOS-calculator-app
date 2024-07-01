//
//  iPadSupport.swift
//  Calculator
//
//  Created by Aleksandra Maksimowska
//

import Foundation
import SwiftUI

extension UIDevice{
    static var isIPad: Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
