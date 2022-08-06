//
//  PKWithGestures.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/09/01.
//

import PencilKit
import SwiftUI

class PKGestureDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

class GestureTarget {
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        print("pan! touches: \(sender.numberOfTouches)")
    }
}

struct PKCanvasWithPanGesture: UIViewRepresentable {
    private let pkGestureDelegate = PKGestureDelegate()
    private let gestureTarget = GestureTarget()
    
    func makeUIView(context: Context) -> PKCanvasView {
        let uiView = PKCanvasView()
        
        uiView.drawingPolicy = .anyInput
        uiView.tool = PKInkingTool(.pen)
        
        
        //uiView.drawingGestureRecognizer.delegate = pkGestureDelegate
        
        let pan = UIPanGestureRecognizer(target: gestureTarget, action: #selector(GestureTarget.pan(_:)))
        uiView.addGestureRecognizer(pan)
        
        return uiView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        print("update")
        //uiView.gestureRecognizers?.forEach { print($0) }
    }
}

struct PKCanvas: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        let uiView = PKCanvasView()
        uiView.drawingPolicy = .anyInput
        uiView.tool = PKInkingTool(.pen)
        return uiView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

struct PKWithGestures: View {
    var body: some View {
        PKCanvasWithPanGesture()
    }
}

struct PKWithGestures_Previews: PreviewProvider {
    static var previews: some View {
        PKWithGestures()
    }
}
