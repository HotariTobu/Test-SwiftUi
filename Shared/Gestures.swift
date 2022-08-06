//
//  Gestures.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/24.
//

import SwiftUI

struct Gestures: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
                
                .highPriorityGesture(
                    TapGesture()
                        .onEnded { _ in
                            print("Circle tapped in high priority A")
                        }
                )
                .onTapGesture {
                    print("Circle tapped")
                }
                .highPriorityGesture(
                    TapGesture()
                        .onEnded { _ in
                            print("Circle tapped in high priority B")
                        }
                )
        }
        /*.highPriorityGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped in high priority A")
                }
        )*/
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
        /*.highPriorityGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped in high priority B")
                }
        )*/
    }
}

struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        Gestures()
    }
}
