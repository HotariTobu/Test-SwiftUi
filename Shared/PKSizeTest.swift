//
//  PKSizeTest.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/09/29.
//

import SwiftUI
import PencilKit

struct PKSizeTest: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                //PKSizeTestCore(size: CGSize(width: proxy.size.width * scale, height: proxy.size.height * scale))
                PKSizeTestCore(scale: scale)
            }
            Slider(value: $scale, in: 0.1...10.0)
        }
    }
}

struct PKSizeTestCore: UIViewRepresentable {
    //let size: CGSize
    let scale: CGFloat
    
    func makeUIView(context: Context) -> PKCanvasView {
        let uiView = PKCanvasView()
        uiView.tool = PKInkingTool(.pen)
        uiView.drawingPolicy = .anyInput
        context.coordinator.lastScale = scale
        return uiView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //uiView.contentScaleFactor = scale
        
        //uiView.contentSize = size
        //uiView.drawing.transform(using: CGAffineTransform(scaleX: scale, y: scale))
        print("last: \(context.coordinator.lastScale)", terminator: "\t")
        let scale = self.scale / context.coordinator.lastScale
        uiView.transform = CGAffineTransform(scaleX: scale, y: scale)
        context.coordinator.lastScale = self.scale
        
        //print("size: \(size)")
        print("scale: \(self.scale)")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var lastScale: CGFloat = 1
    }
}
