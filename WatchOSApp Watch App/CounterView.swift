//
//  ContentView.swift
//  WatchOSApp Watch App
//
//  Created by Karen Stoletniy on 8/2/23.
//

import SwiftUI

struct CounterView: View {
  
  @ObservedObject var connectivityManager = WatchConnectivityManager.shared
  
  @State var count: Int = 0 {
    didSet {
      connectivityManager.send(count.description)
    }
  }
  
  var body: some View {
    HStack {
      Button(action: {
        count += 1
      }, label: {
        Text("+")
          .font(.largeTitle)
      })
      Text(count.description)
        .font(.largeTitle)
      Button(action: {
        count -= 1
      }, label: {
        Text("-")
          .font(.largeTitle)
      })
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      CounterView()
    }
}
