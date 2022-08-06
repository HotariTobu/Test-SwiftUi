//
//  ScrollViewReading.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/26.
//

import SwiftUI

struct ScrollViewReading: View {
    @State private var text: String = ""

    var body: some View {
        VStack {
            ScrollViewReader { (proxy: ScrollViewProxy) in
                HStack {
                    TextField("input row number", text: $text)
                    Button("Scroll") {
                        guard let row = Int(text) else { return }
                        withAnimation {
                            proxy.scrollTo(row, anchor: .top)
                        }
                    }
                }.padding()
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(minimum: 0, maximum: .infinity)),
                            GridItem(.flexible(minimum: 0, maximum: .infinity)),
                        ],
                        alignment: .center,
                        spacing: nil
                    ) {
                        ForEach(0..<100) {
                            Text("\($0)")
                                .frame(height: 100)
                                .id($0)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReading_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReading()
    }
}
