//
//  GeometryReading.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/25.
//

import SwiftUI

struct GeometryReading: View {
    @State private var size = CGSize.zero
    @State private var global = CGRect.zero
    @State private var local = CGRect.zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100, alignment: .center)
                VStack {
                    Text("Size: \(geometry.size.debugDescription)")
                    Text("Global: \(geometry.frame(in: .global).debugDescription)")
                    Text("Local: \(geometry.frame(in: .local).debugDescription)")
                }
            }
            .onChange(of: geometry.frame(in: .global), perform: { value in
                print("\(value)")
            })
        }
        .frame(width: 260, height: 170)
        .padding()
        .onDrag({ NSItemProvider() })
    }
}

struct GeometryReading_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReading()
    }
}
