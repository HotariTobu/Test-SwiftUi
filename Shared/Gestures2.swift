//
//  Gestures2.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/31.
//

import SwiftUI

struct Gestures2: View {
    private let actionCenter = GestureActionCenter()
    
    var body: some View {
        Color.gray
            .simultaneousGesture(
                MagnificationGesture()
                    .onChanged { value in
                        print("changed: \(value)")
                    }
                    .onEnded { value in
                        print("ended: \(value)")
                    }
            )
            .simultaneousGesture(
                RotationGesture(minimumAngleDelta: .zero)
                    .onChanged { value in
                        print("changed: \(value)")
                    }
                    .onEnded { value in
                        print("ended: \(value)")
                    }
            )
        /*let pan = UIPanGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.pan(_:)))
        let tap = UITapGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.tap(_:)))
        let hover = UIHoverGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.hover(_:)))
        let swipe = UISwipeGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.swipe(_:)))
        let rotation = UIRotationGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.rotation(_:)))
        let longPress = UILongPressGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.longPress(_:)))
        let pinch = UIPinchGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.pinch(_:)))
        let edgePan = UIScreenEdgePanGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.edgePan(_:)))
        
        UIEventWrapperView(recognizers: [
            pan, tap, hover, swipe, rotation, longPress, pinch, edgePan
        ])*/
    }
}

class GestureActionCenter {
    private let states = [
        "possible",
        "began",
        "changed",
        "ended",
        "cancelled",
        "failed",
    ]
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        print("tap \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.numberOfTapsRequired)")
    }
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        print("swipe \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.direction)")
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        print("long press \(sender.numberOfTouches) \(states[sender.state.rawValue])")
    }
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        print("pan \(sender.numberOfTouches) \(states[sender.state.rawValue])")
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
        print("pinch \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.scale) \(sender.velocity)")
    }
    
    @objc func rotation(_ sender: UIRotationGestureRecognizer) {
        print("rotation \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.rotation) \(sender.velocity)")
    }
    
    @objc func edgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        print("edge pan \(states[sender.state.rawValue])")
    }
    
    @objc func hover(_ sender: UIHoverGestureRecognizer) {
        print("hover \(states[sender.state.rawValue])")
    }
}

extension UISwipeGestureRecognizer.Direction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .down:
            return "down"
        case .left:
            return "left"
        case .right:
            return "right"
        case .up:
            return "up"
        default:
            return ""
        }
    }
}

struct UIEventWrapperView: UIViewRepresentable {
    let recognizers: [UIGestureRecognizer]
    
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        recognizers.forEach { recognizer in
            view.addGestureRecognizer(recognizer)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct Gestures2_Previews: PreviewProvider {
    static var previews: some View {
        Gestures2()
    }
}
