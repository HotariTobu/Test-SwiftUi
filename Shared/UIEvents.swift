//
//  UIEvents.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/24.
//

import SwiftUI

struct UIEvents: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 50, height: 50, alignment: .center)
                    .onTapGesture {
                        print("tapped circle")
                    }
                Text("TapView1")
                TapView {
                    print("tapped!")
                }
            }
            ZStack {
                Text("TapView2")
                TapView2(recognizer: TouchesRecognizer())
            }
        }
    }
}


class TouchesRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let allTouches = event.allTouches else {
            return
        }
        
        for touch in allTouches {
            guard let uiView = touch.view else {
                continue
            }
            
            print("down | location: \(touch.location(in: uiView)), altitude angle: \(touch.altitudeAngle), azimuth angle: \(touch.azimuthAngle(in: uiView)), force: \(touch.force), type: \(touch.type.rawValue), phase: \(touch.phase.rawValue), major radius: \(touch.majorRadius), to lerance: \(touch.majorRadiusTolerance), maximum force: \(touch.maximumPossibleForce), tap: \(touch.tapCount), time: \(touch.timestamp)")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let allTouches = event.allTouches else {
            return
        }
        
        for touch in allTouches {
            guard let uiView = touch.view else {
                continue
            }
            
            print("up | location: \(touch.location(in: uiView)), altitude angle: \(touch.altitudeAngle), azimuth angle: \(touch.azimuthAngle(in: uiView)), force: \(touch.force), type: \(touch.type.rawValue), phase: \(touch.phase.rawValue), major radius: \(touch.majorRadius), to lerance: \(touch.majorRadiusTolerance), maximum force: \(touch.maximumPossibleForce), tap: \(touch.tapCount), time: \(touch.timestamp)")
        }
    }
}


extension UIEvents {
    class Recognizer: UIGestureRecognizer {
        override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
            print("\(#function)")
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
            print("\(#function)")
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
            print("\(#function)")
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
            print("\(#function)")
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
            print("\(#function)")
        }
        
        override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent) {
            print("\(#function)")
        }
        
        override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent) {
            print("\(#function)")
        }
        
        override func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent) {
            print("\(#function)")
        }
        
        override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent) {
            print("\(#function)")
        }
    }
}

struct TapView: UIViewRepresentable {
    var tappedCallback: (() -> Void)
    
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let gesture = SingleTouchDownGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped))
        view.addGestureRecognizer(gesture)
        return view
    }
    
    func makeCoordinator() -> TapView.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

extension TapView {
    class Coordinator: NSObject {
        var tappedCallback: (() -> Void)
        
        init(tappedCallback: @escaping (() -> Void)) {
            self.tappedCallback = tappedCallback
        }
        
        @objc func tapped(gesture:UITapGestureRecognizer) {
            self.tappedCallback()
        }
    }
}

protocol UITapDelegate {
    
}

struct SomeTapDelegate {
    
}

class SingleTouchDownGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .recognized
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
}

struct TapView2: UIViewRepresentable {
    let recognizer: UIGestureRecognizer
    
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addGestureRecognizer(recognizer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct UIEvents_Previews: PreviewProvider {
    static var previews: some View {
        UIEvents()
    }
}
