//
//  ContentView.swift
//  Card Motion
//
//  Created by MR.Robot 💀 on 13/08/2020.
//  Copyright © 2020 Joselson Dias. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var isCardTapped: Bool = false
    @State var scrollingDisabled = false
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(cardSection) { item in
                        GeometryReader { geometry in
                            VStack {
                                CardBalance(isCardTapped: self.$isCardTapped, cardData: item)
                                Card(isCardTapped: self.$isCardTapped, card: item)
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 20) / 30), axis: (x: 10, y: -20, z: 0))
                            }
                            .padding(.horizontal, 19)
                            .offset(y: -130)
                        }
                        .frame(width: 375, height: 400)
                        .moveDisabled(self.isCardTapped ? true : false)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            
            
            VStack {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
                    }
                }
            }
            .padding(.vertical, 20)
            .opacity(isCardTapped ? 0 : 0.5)
            .animation(.easeInOut)
            
        PaymentHistory()
            .offset(y: isCardTapped ? 210 : 690)
            .animation(.easeInOut(duration: 0.25))

        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
//        .onTapGesture {
//            if self.isCardTapped == true {
//                self.isCardTapped = false
//            }
//        } //causing conflict with card tap
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Card: View {
    @Binding var isCardTapped: Bool
    var card: CardStructure
    
    var body: some View {
        VStack {
            HStack {
                Text("•••• •••• •••• \(String(card.cardNumber.suffix(4)))")
                    .foregroundColor(Color(#colorLiteral(red: 0.8989498147, green: 0.7744829563, blue: 1, alpha: 1)))
                Spacer()
            }
            Spacer()
            HStack {
                Text("\(card.cardCurrency) \(card.cardAmount)")
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .bold()
                    .font(.system(size: 28))
                Spacer()
                Image(card.cardProviderLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 40)
                    .padding(.trailing, 9)
            }
        }
        .frame(width: 300, height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [card.linearColor1, card.linearColor2]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .cornerRadius(15)
        .scaleEffect(self.isCardTapped ? 1 : 1.20)
        .rotationEffect(Angle(degrees: self.isCardTapped ? 0 : 90))
        .offset(y: self.isCardTapped ? -170 : 0)
        .shadow(color: card.shadow.opacity(0.5), radius: 10, x: 0, y: 15)
        .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
        .onTapGesture {
            self.isCardTapped.toggle()
            }
    }
}

struct CardBalance: View {
    @Binding var isCardTapped: Bool
    var cardData: CardStructure
    var body: some View {
        VStack(spacing: 10) {
            Text("Current Balance")
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .opacity(isCardTapped ? 0 : 1)
            Text("AKZ \(cardData.cardAmount)")
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .bold()
                .font(.system(size: 38))
                .opacity(isCardTapped ? 0 : 1)
            Text("Transactions")
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .bold()
                .font(.system(size: 31))
                .opacity(isCardTapped ? 1 : 0)
                .transition(.slide)

        }
        .padding(.vertical, 80)
        .offset(y: isCardTapped ? -140 : 0)
        .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct CardStructure: Identifiable {
    var id = UUID()
    var cardNumber: String
    var cardProviderLogo: String
    var cardCurrency: String
    var cardAmount: Int
    var linearColor1: Color
    var linearColor2: Color
    var shadow: Color
}


let cardSection = [
    CardStructure(cardNumber: "4510 6459 8301 6543", cardProviderLogo: "mastercard-icon", cardCurrency: "AKZ", cardAmount: 1464, linearColor1: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), linearColor2: Color(#colorLiteral(red: 0.6746161063, green: 0.4407705607, blue: 1, alpha: 1)), shadow: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    CardStructure(cardNumber: "6227 9067 1159 4103", cardProviderLogo: "visa-icon", cardCurrency: "AKZ", cardAmount: 4564, linearColor1: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), linearColor2: Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), shadow: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))),
    CardStructure(cardNumber: "6397 1190 3844 1503", cardProviderLogo: "mastercard-icon", cardCurrency: "AKZ", cardAmount: 6564, linearColor1: Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)), linearColor2: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), shadow: Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))),
    CardStructure(cardNumber: "5019 4973 5028 4325", cardProviderLogo: "visa-icon", cardCurrency: "AKZ", cardAmount: 7564, linearColor1: Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), linearColor2: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), shadow: Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)))
]
