//
//  Notifications.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2022/02/17.
//

import SwiftUI

struct Notifications: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                // first
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                // second
                
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                var dateComponents = DateComponents()
                dateComponents.second = 3
                let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
            
            Button("Stop Notification") {
                let center = UNUserNotificationCenter.current()
                center.getDeliveredNotifications(completionHandler: { notifications in
                    for notification in notifications {
                        print(notification)
                    }
                })
                center.getPendingNotificationRequests(completionHandler: { notifications in
                    for notification in notifications {
                        print(notification)
                    }
                })
                center.removeAllPendingNotificationRequests()
            }
        }
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
