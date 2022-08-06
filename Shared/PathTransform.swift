//
//  PathTransform.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/30.
//

import SwiftUI

struct PathTransform: View {
    private let transform = CGAffineTransform(scaleX: 100, y: 100)
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0.5, y: 0))
            path.addLine(to: CGPoint(x: 1, y: 1))
            path.addLine(to: CGPoint(x: 0, y: 1))
            path.addCurve(to: CGPoint(x: 2, y: 2), control1: CGPoint(x: 3, y: 2), control2: CGPoint(x: 0, y: 7))
        }
        //.transform(transform)
        .transformEffect(transform)
        //.scaledToFit()
        //.scaledToFill()
    }
}

struct PathTransform_Previews: PreviewProvider {
    static var previews: some View {
        PathTransform()
    }
}
