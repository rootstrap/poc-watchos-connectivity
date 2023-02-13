//
//  CounterView.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 8/2/23.
//

import SwiftUI

struct CounterView: View {
  
  @ObservedObject var connectivityManager = WatchConnectivityManager.shared
  
  @State var count: Int = 0
  
  var body: some View {
    HStack {
      Button(action: {
        count -= 1
        connectivityManager.send(count)
      }, label: {
        Text("-")
          .font(.largeTitle)
      })
      .padding()
      Text(count.description)
        .font(.largeTitle)
        .padding()
      Button(action: {
        count += 1
        connectivityManager.send(count)
      }, label: {
        Text("+")
          .font(.largeTitle)
      })
    }
    .padding()
    .onReceive(
      connectivityManager.$notificationMessage,
      perform: { message in
        guard let message = message else { return }
        count = message.value
      }
    )
  }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
