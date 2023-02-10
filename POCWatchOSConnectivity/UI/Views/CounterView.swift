//
//  CounterView.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 8/2/23.
//

import SwiftUI

struct CounterView: View {
  
  @ObservedObject var connectivityManager = WatchConnectivityManager.shared
  
//  @State var count: String? = connectivityManager.notificationMessage?.text
  
    var body: some View {
      HStack {
        Button("+") {
//          count += 1
        }
        .padding()
        .background(.indigo ,in: Circle())
        .tint(.white)
        .font(.largeTitle)
        Spacer()
        Text(connectivityManager.notificationMessage?.text ?? "0")
          .font(.largeTitle)
        Spacer()
        Button("-") {
//          count -= 1
        }
        .padding()
        .background(.indigo ,in: Circle())
        .tint(.white)
        .font(.largeTitle)
      }
      .frame(width: 200)
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
