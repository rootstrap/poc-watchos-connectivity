//
//  CounterView.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 8/2/23.
//

import SwiftUI

struct CounterView: View {
  @State var count: Int = 0
  
    var body: some View {
      HStack {
        Button(action: {
          count += 1
        }, label: {
          Text("+")
            .font(.largeTitle)
        })
        Spacer()
        Text(count.description)
          .font(.largeTitle)
        Spacer()
        Button(action: {
          count -= 1
        }, label: {
          Text("-")
            .font(.largeTitle)
        })
      }
      .frame(width: 200)
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
