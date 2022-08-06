//
//  DataToParent.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/09/02.
//

import SwiftUI

struct DataToParent: View {
    var body: some View {
        CirclePreferenceView()
    }
}

struct PData: Equatable {
    let idx: Int
    var rect: CGRect
}

struct PKey: PreferenceKey {
    typealias Value = [PData]
    
    static var defaultValue: [PData] = []
    
    static func reduce(value: inout [PData], nextValue: () -> [PData]) {
        value.append(contentsOf: nextValue())
    }
}

struct CirclePreferenceView: View {
    
    @State private var activeIdx: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 2)
    @State var isStarted:Bool = false
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .background(BGView(idx: 0))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 0
                    }
                    .padding()
                Circle()
                    .fill(Color.pink)
                    .frame(width: 150, height: 150)
                    .background(BGView(idx: 1))
                    .onTapGesture {
                        self.isStarted = true
                        self.activeIdx = 1
                    }
                    .padding()
            }
            .onPreferenceChange(PKey.self) {  preference in
                for p in preference {
                    self.rects[p.idx] = p.rect
                }
            }
            
            Circle()
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                .offset(x: rects[activeIdx].minX , y: rects[activeIdx].minY)
                .animation(.linear(duration: isStarted ? 0.5 : 0))
            
        }.coordinateSpace(name: "myCoordination")
    }
}

struct BGView: View {
    let idx: Int
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color.clear)
                .preference(key: PKey.self, value: [PData(idx: self.idx, rect: geometry.frame(in: .named("myCoordination")))])
        }
    }
}

struct DataToParent_Previews: PreviewProvider {
    static var previews: some View {
        DataToParent()
    }
}
