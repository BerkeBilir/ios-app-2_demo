//
//  CreatingScreen.swift
//  ios-app-2
//
//  Created by BERKE on 25.01.2022.
//

import SwiftUI

struct CreatingScreen: View {
    
    @State var pizzas: [Pizza] = [
        Pizza(breadName: "bread-2"),
        Pizza(breadName: "bread-1"),
        Pizza(breadName: "bread-3"),
    ]
    
    @State var currentPizza: String = "bread-2"
    @State var currentSize: PizzaSize = .medium
    
    @Namespace var animation
    
    let toppings: [String] = ["basil", "onion", "brroccoli", "mushroom", "sausage"]
    
    var body: some View {
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                GeometryReader{ proxy in
                    
                    let size = proxy.size
                    
                    ZStack{
                        Image("tabak")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 30)
                            .padding(.vertical)
                            .background(.white)
                        
                        TabView(selection: $currentPizza) {
                            ForEach(pizzas) { pizza in
                                ZStack{
                                    Image(pizza.breadName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(40)
                                    
                                    ToppingsView(toppings: pizza.toppings, pizza: pizza, width: (size.width / 2) - 45)
                                }
                                .scaleEffect(currentSize == .large ? 1.1:(currentSize == .medium ? 0.98: 0.9))
                                .tag(pizza.breadName)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .frame(height: 300)
                
                HStack(spacing: 20) {
                    ForEach(PizzaSize.allCases,id: \.rawValue) { size in
                        Button{
                            withAnimation{
                                currentSize = size
                            }
                        } label: {
                            Text(size.rawValue)
                                .font(.title2)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .padding()
                                .background(
                                    ZStack{
                                        if currentSize == size {
                                            Color.white
                                                .clipShape(Circle())
                                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                                .shadow(color: .black.opacity(0.03), radius: 5, x: -5, y: -5)
                                                .matchedGeometryEffect(id: "SIZEINDICATOR", in: animation)
                                        }
                                    }
                                )
                        }
                    }
                }
                .padding(.top, 10)
                
                Text("Pizzanı kişileştir")
                    .font(.headline)
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.leading)
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: -10) {
                            ForEach(toppings, id: \.self) { topping in
                                Image("\(topping)_1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding(12)
                                    .background(
                                        Color.green
                                            .clipShape(Circle())
                                            .opacity(isAdded(topping: topping) ? 0.15 : 0)
                                            .animation(.easeInOut, value: currentPizza)
                                    )
                                    .padding()
                                    .contentShape(Circle())
                                    .onTapGesture {
                                        if isAdded(topping: topping) {
                                            if let index = pizzas[getIndex(breadName: currentPizza)].toppings.firstIndex(where: { currentTopping in
                                                return topping == currentTopping.toppingName
                                            }) {
                                                pizzas[getIndex(breadName: currentPizza)].toppings.remove(at: index)
                                            }
                                            return
                                        }
                                        
                                        var positions: [CGSize] = []
                                        
                                        for _ in 1...20 {
                                            positions.append(.init(width: .random(in: -20...60), height: .random(in: -45...45)))
                                        }
                                        
                                        let toppingObject = Topping(toppingName: topping, randomToppingPostions: positions)
                                        withAnimation {
                                            pizzas[getIndex(breadName: currentPizza)].toppings.append(toppingObject)
                                        }
                                    }
                                    .tag(topping)
                            }
                        }
                    }
                    .onChange(of: currentPizza) { _ in
                        withAnimation {
                            proxy.scrollTo(toppings.first ?? "", anchor: .leading)
                        }
                    }
                }
                
                Button{
                    
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                        Text("Sepete ekle")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(.green)
                    .cornerRadius(15)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    func getIndex(breadName: String)-> Int {
        let index = pizzas.firstIndex { pizza in
            return pizza.breadName == breadName
        } ?? 0
        return index
    }
    
    func isAdded(topping: String)-> Bool {
        let status = pizzas[getIndex(breadName: currentPizza)].toppings.contains { currentTopping in
            return currentTopping.toppingName == topping
        }
        return status
    }
    
    @ViewBuilder
    func ToppingsView(toppings: [Topping], pizza: Pizza , width: CGFloat)-> some View {
        Group {
            ForEach(toppings.indices, id: \.self) { index in
                let topping = toppings[index]
                
                ZStack{
                    ForEach(1...20,id: \.self) { subIndex in
                        
                        let rotation : Double = Double(subIndex) * 72
                        let crtIndex = (subIndex > 10 ? (subIndex - 10) : subIndex)
                        
                        Image("\(topping.toppingName)_\(crtIndex)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .offset(x: (width / 2) -
                                    topping.randomToppingPostions[subIndex - 1].width, y:
                                        topping.randomToppingPostions[subIndex - 1].height)
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                .scaleEffect(topping.isAdded ? 1 : 10, anchor: .center)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                        withAnimation {
                            pizzas[getIndex(breadName: pizza.breadName)].toppings[index].isAdded = true
                        }
                    }
                }
            }
        }
    }
}

struct CreatingScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreatingScreen()
            .preferredColorScheme(.light)
    }
}

enum PizzaSize: String, CaseIterable{
    case small = "Küçük"
    case medium = "Orta"
    case large = "Büyük"
}
