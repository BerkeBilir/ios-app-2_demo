//
//  ContentView.swift
//  ios-app-2
//
//  Created by BERKE on 25.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ZStack{
                        Color("navColor")
                            .ignoresSafeArea(.all, edges: .top)
                            .frame(height: 60)
                        HStack{
                            Image(systemName: "text.justify")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                            Spacer()
                            Text("pizza")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .font(.title)
                                .padding(.bottom)
                            Spacer()
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                        }
                    }
                    Spacer()
                }
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 350)
                            .foregroundColor(.mint)
                            .padding()
                            .padding(.top)
                        VStack{
                            Image("pizza")
                                .resizable()
                                .frame(width: 280, height: 250, alignment: .top)
                                .cornerRadius(10)
                                .offset(y: -30)
                        }
                        VStack{
                            Text("Kendi pizzanı oluştur")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .offset(y: 150)
                        }
                    }
                    Spacer()
                }
                .padding()
                .padding(.top)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)
                .shadow(color: .black.opacity(0.3), radius: 10, x: -5, y: 5)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: -5)
                .shadow(color: .black.opacity(0.3), radius: 10, x: -5, y: -5)
                .padding()
                .padding(.top, 50)
                VStack{
                    NavigationLink(destination: CreatingScreen(), label: {
                        Text("Başla")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 20)
                            .padding()
                            .background(.green)
                            .cornerRadius(20)
                            .navigationTitle("Geri")
                    })
                }
                .padding(.top, 500)
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
