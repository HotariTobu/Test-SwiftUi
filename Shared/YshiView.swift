//
//  YshiView.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/12/24.
//

import SwiftUI

struct YshiView: View {
    @State var h: Double = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("何でやねん")
                    .foregroundColor(Color(hue: h, saturation: 1.0, brightness: 1.0))
                    .scaleEffect(CGFloat(h * 100))
                Button(action: {
                    withAnimation {
                    }
                    var newH: Double = h + 0.1
                    if newH > 1 {
                        newH -= 1
                    }
                    h = newH
                }, label: {
                    Text("ボタン")
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                }
                .shadow(color: Color(hue: 0,saturation: 1,brightness: 1), radius: 3, x: 1, y: 1)
            }
            Label(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, systemImage: "8.circle")
        }
    }
}

struct YshiView_Previews: PreviewProvider {
    static var previews: some View {
        YshiView()
    }
}
