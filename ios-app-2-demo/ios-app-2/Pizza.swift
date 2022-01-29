//
//  Pizza.swift
//  ios-app-2
//
//  Created by BERKE on 25.01.2022.
//

import SwiftUI

struct Pizza: Identifiable {
    var id = UUID().uuidString
    var breadName: String
    var toppings: [Topping] = []
}

