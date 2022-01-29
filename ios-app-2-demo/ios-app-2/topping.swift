//
//  topping.swift
//  ios-app-2
//
//  Created by BERKE on 25.01.2022.
//

import SwiftUI

struct Topping: Identifiable {
    var id = UUID().uuidString
    var toppingName: String
    var isAdded: Bool = false
    var randomToppingPostions: [CGSize] = []
}
