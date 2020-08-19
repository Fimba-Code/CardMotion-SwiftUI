//
//  PaymentHistory.swift
//  Animotion
//
//  Created by MR.Robot 💀 on 13/08/2020.
//  Copyright © 2020 Joselson Dias. All rights reserved.
//

import SwiftUI

struct PaymentHistory: View {
    init() {
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    
//    @Binding var show: Bool  //Causes conflict with init
    var body: some View {
        
        VStack {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .padding(.vertical, 13)
                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))

            
            List{
                ForEach(historyData) { payment in
                    PaymentHistoryDetail(paymentDetail: payment)
            }
            }
            .padding(.vertical, 1)
            .padding(.bottom, 8)
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.1257158969, green: 0.1361153488, blue: 0.1512231692, alpha: 1)))
        .cornerRadius(20)
    }
}

struct PaymentHistory_Previews: PreviewProvider {
    static var previews: some View {
        PaymentHistory()
    }
}

struct PaymentHistoryDetail: View {
    
    var paymentDetail: HistoryStructure
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(Color.white)
                    .opacity(0.25)
                Image(paymentDetail.serviceProviderLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            .frame(width: 45, height: 45)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(paymentDetail.serviceName)
                    .foregroundColor(Color.white)
                    .bold()
                Text(paymentDetail.serviceDateCharged)
                    .foregroundColor(Color.white)
                    .opacity(0.25)
            }
            Spacer()
            Text("- AKZ \(paymentDetail.serviceAmountCharged)")
                .bold()
                .frame(width: 115, height: 20, alignment: .leading)
                .foregroundColor(Color.white)
        }
    }
}

struct HistoryStructure: Identifiable, Hashable {
    var id = UUID()
    var serviceProviderLogo: String
    var serviceName: String
    var serviceDateCharged: String
    var serviceAmountCharged: Int
}


let historyData = [
    HistoryStructure(serviceProviderLogo: "netflix", serviceName: "Netflix", serviceDateCharged: "Today", serviceAmountCharged: 8200),
    HistoryStructure(serviceProviderLogo: "PizzaHut", serviceName: "PizzaHut", serviceDateCharged: "Today", serviceAmountCharged: 18000),
    HistoryStructure(serviceProviderLogo: "Unitel", serviceName: "Unitel", serviceDateCharged: "Yesterday", serviceAmountCharged: 11000),
    HistoryStructure(serviceProviderLogo: "Spotify", serviceName: "Spotify", serviceDateCharged: "Friday", serviceAmountCharged: 7600),
    HistoryStructure(serviceProviderLogo: "Codigo-qr", serviceName: "Código QR", serviceDateCharged: "Thursday", serviceAmountCharged: 8900),
    HistoryStructure(serviceProviderLogo: "Unitel", serviceName: "Unitel", serviceDateCharged: "Wednesday", serviceAmountCharged: 16000),
        HistoryStructure(serviceProviderLogo: "netflix", serviceName: "Netflix", serviceDateCharged: "Wednesday", serviceAmountCharged: 22200)
]
