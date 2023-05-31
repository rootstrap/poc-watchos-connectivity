//
//  WatchConnectivityManager.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 10/2/23.
//

import Foundation
import WatchConnectivity

struct NotificationMessage: Identifiable {
    let id = UUID()
    let value: Int
}

class WatchConnectivityManager: NSObject, ObservableObject {
  
  static let shared = WatchConnectivityManager()
  private let kMessageKey = "message" //improve
  @Published var notificationMessage: NotificationMessage? = nil
  
  private override init() {
    super.init()
    
    if WCSession.isSupported() {
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
  }
  
  func send(_ value: Int) {
      guard WCSession.default.activationState == .activated else {
        return
      }
      #if os(iOS)
      guard WCSession.default.isWatchAppInstalled else {
          return
      }
      #else
      guard WCSession.default.isCompanionAppInstalled else {
          return
      }
      #endif
      
      //Messages can only be sent while the sending app is running
      WCSession.default.sendMessage([kMessageKey : value], replyHandler: nil) { error in
          print("Cannot send message: \(String(describing: error))")
      }
    /** ----------------------------------- ALTERNATIVES  -----------------------------------
        - updateApplicationContext(_:) 
        - sendMessageData(_:replyHandler:errorHandler:)
     
        WARNING: The Simulator app doesn’t support the three followings methods.
         Background transfers continue transferring when the sending app exits. The
         counterpart app (other side) is not required to be running for background
         transfers to continue. The system will transfer content at opportune times.
     
        - transferUserInfo(_:)
        - transferCurrentComplicationUserInfo(_:)
     
     */
  }
}

extension WatchConnectivityManager: WCSessionDelegate {
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
      if let notificationText = message[kMessageKey] as? Int {
          DispatchQueue.main.async { [weak self] in
              self?.notificationMessage = NotificationMessage(value: notificationText)
          }
      }
  }
  
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
      // activates a session in case it gets deactivated.
      // This can happen if the user owns several watches and we need to support watch switching.
        session.activate()
    }
    #endif
}
