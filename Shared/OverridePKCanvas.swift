//
//  OverridePKCanvas.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/31.
//

import SwiftUI
import PencilKit

struct TouchElement: ReorderableElement {
    let id = UUID()
    let touch: UITouch
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct OverridePKCanvas: View {
    @State private var touchElement = TouchElement(touch: UITouch())
    
    private let types = [
        "direct",
        "indirect",
        "pencil",
        "indirectPointer",
    ]
    
    private let phases = [
        "began ",
        "moved",
        "stationary",
        "ended",
        "cancelled",
        "regionEntered",
        "regionMoved",
        "regionExited",
    ]
    
    var body: some View {
        VStack {
            HStack {
                let touch = touchElement.touch
                ZStack {
                    if touch.maximumPossibleForce != 0 {
                        ResizedCircle(color: .black, value: touch.force / touch.maximumPossibleForce 
                                      * 100)
                    }
                    
                    RotatedBar(color: .purple, value: touch.altitudeAngle)
                    RotatedBar(color: .yellow, value: touch.azimuthAngle(in: touch.view))
                    
                    ResizedCircle(color: .blue, value: touch.majorRadius + touch.majorRadiusTolerance)
                    ResizedCircle(color: .green, value: touch.majorRadius)
                    ResizedCircle(color: .red, value: touch.majorRadius - touch.majorRadiusTolerance)
                }
                .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("type: \(types[touch.type.rawValue])")
                    Text("phase: \(phases[touch.phase.rawValue])")
                }
                .frame(width: 150, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            
            ZStack {
                //Color.blue
                
                MyPKCanvasWrapper {
                    if let touch = $0.first {
                        self.touchElement = TouchElement(touch: touch)
                    }
                }
            }
            
        }
    }
}

struct MyPKCanvasWrapper: UIViewRepresentable {
    let onChanged: (Set<UITouch>) -> Void
    
    func makeUIView(context: Context) -> MyPKCanvas {
        let uiView = MyPKCanvas(onChanged: onChanged)
        uiView.tool = PKInkingTool(.pen, color: .red, width: 10)
        uiView.drawingPolicy = .anyInput
        uiView.backgroundColor = .clear
        uiView.isMultipleTouchEnabled = true
        
        let pinch = UIPinchGestureRecognizer(target: uiView, action: #selector(MyPKCanvas.pinch(_:)))
        uiView.addGestureRecognizer(pinch)
        
        
        uiView.drawingGestureRecognizer.requiresExclusiveTouchType = true
        
        return uiView
    }
    
    func updateUIView(_ uiView: MyPKCanvas, context: Context) {
    }
    
    typealias UIViewType = MyPKCanvas
}

class MyPKCanvas: PKCanvasView {
    let onChanged: (Set<UITouch>) -> Void
    
    private let dele = PKDelegate3()
    
    init(onChanged: @escaping (Set<UITouch>) -> Void) {
        self.onChanged = onChanged
        super.init(frame: .zero)
        
        drawingGestureRecognizer.delegate = dele
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onChanged(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        onChanged(touches)
        //print(drawingGestureRecognizer.state.rawValue)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onChanged(touches)
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        onChanged(touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        onChanged(touches)
    }
    
    @objc func pinch(_ sender: UIGestureRecognizer) {
        print("pinch!!")
    }
}

class PKDelegate3: NSObject, UIGestureRecognizerDelegate {
    
    @available(iOS 3.2, *)
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("\(#function)")
        return gestureRecognizer.numberOfTouches == 1
    }
    
    @available(iOS 3.2, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("count: \(gestureRecognizer.numberOfTouches)")
        return gestureRecognizer.view == otherGestureRecognizer.view
    }
    
    @available(iOS 7.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //print("\(#function), \(otherGestureRecognizer)")
        return false
    }

    @available(iOS 7.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //print("\(#function), \(otherGestureRecognizer)")
        return false
    }
    
    /*@available(iOS 3.2, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("\(#function), \(touch)")
        return true
    }
    
    @available(iOS 9.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        print("\(#function), \(press)")
        return true
    }
    
    @available(iOS 13.4, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        print("\(#function), \(event)")
        return true
    }*/
}


class PKDelegate2: NSObject, UIGestureRecognizerDelegate {
    
    // called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
    @available(iOS 3.2, *)
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("\(#function)")
        return true
    }

    
    // called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
    // return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
    //
    // note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
    @available(iOS 3.2, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("\(#function), \(otherGestureRecognizer)")
        return true
    }

    
    // called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
    // return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
    //
    // note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
    @available(iOS 7.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        print("\(#function), \(otherGestureRecognizer)")
        return false
    }

    @available(iOS 7.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("\(#function), \(otherGestureRecognizer)")
        return false
    }

    
    // called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
    @available(iOS 3.2, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("\(#function), \(touch)")
        return true
    }

    
    // called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
    @available(iOS 9.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        print("\(#function), \(press)")
        return true
    }

    
    // called once before either -gestureRecognizer:shouldReceiveTouch: or -gestureRecognizer:shouldReceivePress:
    // return NO to prevent the gesture recognizer from seeing this event
    @available(iOS 13.4, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        print("\(#function), \(event)")
        return true
    }
}


class PKDelegate: NSObject, PKCanvasViewDelegate {
    
    /// Called after the drawing on the canvas did change.
    ///
    /// This may be called some time after the `canvasViewDidEndUsingTool:` delegate method.
    /// For example, when using the Apple Pencil, pressure data is delayed from touch data, this
    /// means that the user can stop drawing (`canvasViewDidEndUsingTool:` is called), but the
    /// canvas view is still waiting for final pressure values; only when the final pressure values
    /// are received is the drawing updated and this delegate method called.
    ///
    /// It is also possible that this method is not called, if the drawing interaction is cancelled.
    ///
    /// @param canvasView The canvas view that changed.
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("\(#function)")
    }

    
    /// Called after setting `drawing` when the entire drawing is rendered and visible.
    ///
    /// This method lets you know when the canvas view finishes rendering all of the currently
    /// visible content. This can be used to delay showing the canvas view until all content is visible.
    ///
    /// This is called every time the canvasView transitions from partially rendered to fully rendered,
    /// including after setting the drawing, and after zooming or scrolling.
    ///
    /// @param canvasView The canvas view that finished rendering.
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("\(#function)")
    }

    
    /// Called when the user starts using a tool, eg. selecting, drawing, or erasing.
    ///
    /// This does not include moving the ruler.
    ///
    /// @param canvasView The canvas view that the user started interacting with.
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("\(#function)")
    }

    
    /// Called when the user stops using a tool, eg. selecting, drawing, or erasing.
    ///
    /// @param canvasView The canvas view that the user ended interacting with.
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("\(#function)")
    }
}

struct OverridePKCanvas_Previews: PreviewProvider {
    static var previews: some View {
        OverridePKCanvas()
    }
}

struct ResizedCircle: View {
    let color: Color
    let value: CGFloat
    
    var body: some View {
        if (0 ... 200).contains(value) {
            let size = abs(value)
            Circle()
                .fill(color)
                .frame(width: size, height: size)
        }
        else {
            //Text("\(value)")
        }
    }
}

struct RotatedBar: View {
    let color: Color
    let value: CGFloat
    
    var body: some View {
        Capsule()
            .fill(LinearGradient(gradient: Gradient(colors: [.clear, .clear, color, color]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 100, height: 4)
            .rotationEffect(.radians(Double(value)), anchor: .center)
    }
}





/*
 
 
 struct PKCanvasWrapper3: UIViewRepresentable {
     func makeUIView(context: Context) -> PKCanvasView {
         let uiView = PKCanvasView()
         uiView.tool = PKInkingTool(.pen, color: .red, width: 10)
         uiView.drawingPolicy = .anyInput
         return uiView
     }
     
     func updateUIView(_ uiView: PKCanvasView, context: Context) {
         
     }
     
     typealias UIViewType = PKCanvasView
 }

 struct PKCanvasWrapper2: UIViewRepresentable {
     private let onChange: (Set<UITouch>) -> Void
     private let recognizer: UIGestureRecognizer
     
     init(onChange: @escaping (Set<UITouch>) -> Void) {
         self.onChange = onChange
         self.recognizer = PKCanvasWrapper2Recognizer(onChanged: onChange)
     }
     
     func makeUIView(context: Context) -> PKCanvasView {
         let uiView = PKCanvasView()
         uiView.tool = PKInkingTool(.pen, color: .red, width: 10)
         uiView.drawingPolicy = .anyInput
         //uiView.drawingGestureRecognizer..delegate
         uiView.addGestureRecognizer(recognizer)
         return uiView
     }
     
     func updateUIView(_ uiView: PKCanvasView, context: Context) {
         
     }
     
     typealias UIViewType = PKCanvasView
 }

 class PKCanvasWrapper2Recognizer: UIGestureRecognizer {
     let onChanged: (Set<UITouch>) -> Void
     
     init(onChanged: @escaping (Set<UITouch>) -> Void) {
         self.onChanged = onChanged
         super.init(target: nil, action: nil)
     }
     
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
         fire(touches, with: event)
     }
     
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
         fire(touches, with: event)
     }
     
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
         fire(touches, with: event)
     }
     
     override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
         fire(touches, with: event)
     }
     
     func fire(_ touches: Set<UITouch>, with event: UIEvent) {
         if let allTouches = event.allTouches {
             onChanged(allTouches)
         }
         else {
             onChanged(touches)
         }
     }
 }
 */
