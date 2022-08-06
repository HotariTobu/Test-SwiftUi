//
//  LifeCycleTest.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/16.
//

import SwiftUI

struct LifeCycleTest: View {
    var body: some View {
        SomethingNotInheritingView()
            .content
    }
}

struct SomethingNotInheritingView {
    var content: some View {
        SomeViewWithUpdateCycle()
    }
}

struct SomeViewWithUpdateCycle: View {
    @State var num = 10
    
    var body: some View {
        VStack {
            Text("\(num)")
            Stepper(value: $num, in: -20 ... 30) {
                EmptyView()
            }
        }
    }
}

struct LifeCycleTest_Previews: PreviewProvider {
    static var previews: some View {
        LifeCycleTest()
    }
}
