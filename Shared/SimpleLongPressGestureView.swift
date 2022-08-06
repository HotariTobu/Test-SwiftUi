//
//  SimpleLongPressGestureView.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/22.
//

import SwiftUI

struct SimpleLongPressGestureView: View {
    @GestureState var isDetectingLongPress = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 2)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }

    var body: some View {
        Circle()
            .fill(self.isDetectingLongPress ? Color.red : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(longPress)
    }
}

struct SimpleLongPressGestureView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleLongPressGestureView()
    }
}
