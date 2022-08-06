//
//  SomeView.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/11.
//

import SwiftUI

struct WrappingUIView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        print("UIView updated!")
    }
}
