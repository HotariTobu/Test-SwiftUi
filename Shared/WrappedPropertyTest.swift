//
//  WrappedPropertyTest.swift
//  Test-SwiftUi (iOS)
//
//  Created by HotariTobu on 2021/08/15.
//

import SwiftUI

struct WrappedPropertyTest: View {
    @State var bid1 = "normal"
    @State var bid2 = "abnormal"
    
    var ev = ExternallyWrappingView(bid: .constant("super abnormal"))
    
    var body: some View {
        VStack {
            JustCustomView(bid: $bid1)
            Button("string") {
                bid1 = numbers[Int.random(in: 0 ..< 10)]
            }
            Spacer()
            ExternallyWrappingView(bid: $bid2)
                .content
            Button("string") {
                bid2 = numbers[Int.random(in: 0 ..< 10)]
            }
            Spacer()
            ev.content
            HStack {
                Button("int") {
                    ev.obo.num = Int.random(in: 0 ... 100)
                }
                Button("double") {
                    ev.val = Double.random(in: 0 ... 10)
                }
                Button("string") {
                    ev.bid = numbers[Int.random(in: 0 ..< 10)]
                }
                Button("int") {
                   // ev.trf = Int.random(in: 0 ... 100)
                }
            }
        }
    }
}

let numbers = ["null", "eins", "zwei", "drei", "vier", "fuenf", "sechs", "sieben", "acht", "neun", "zehn"]

struct JustCustomView: View {
    @EnvironmentObject var env: ExternalObject1
    @ObservedObject var obo = ExternalObject2()
    @State var val = 3.14
    @Binding var bid: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(env.isOn ? "true" : "false")")
                Button("bool") {
                    env.isOn.toggle()
                }
            }
            HStack {
                Text("\(obo.num)")
                Button("int") {
                    obo.num = Int.random(in: 0 ... 100)
                }
            }
            HStack {
                Text("\(val)")
                Button("double") {
                    val = Double.random(in: 0 ... 10)
                }
            }
            Text("\(bid)")
        }
    }
}

struct ExternallyWrappingView {
    //@EnvironmentObject var env: ExternalObject1
    @ObservedObject var obo = ExternalObject2()
    @State var val = 3.14
    @Binding var bid: String
    var trf = 90
    
    var content: some View {
        VStack {
            /*HStack {
                Text("\(env.isOn ? "true" : "false")")
                Button("bool") {
                    env.isOn.toggle()
                }
            }*/
            HStack {
                Text("\(obo.num)")
                Button("int") {
                    obo.num = Int.random(in: 0 ... 100)
                }
            }
            HStack {
                Text("\(val)")
                Button("double") {
                    val = Double.random(in: 0 ... 10)
                }
            }
            Text("\(bid)")
            Text("\(trf)")
        }
    }
}

class ExternalObject1: ObservableObject {
    @Published var isOn = false
}

class ExternalObject2: ObservableObject {
    @Published var num = 4
}

struct WrappedPropertyTest_Previews: PreviewProvider {
    static var previews: some View {
        WrappedPropertyTest()
            .environmentObject(ExternalObject1())
    }
}
