//
//  PathTest.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/15.
//

import SwiftUI

struct PathTest: View {
    @Binding var foreground: Color
    @Binding var background: Color
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 50, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 50))
            path.addLine(to: CGPoint(x: 100, y: 50))
        }
        .stroke(foreground)
        .background(background)
        .frame(width: 200, height: 200, alignment: .center)
        
        Circle()
            .fillAndStroke(fillContent: background, strokeContent: foreground, strokeStyle: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .round, miterLimit: .pi, dash: [CGFloat(20)], dashPhase: CGFloat(10)))
            
          //  .strokeBorder(foreground)
        
        Triangle()
            .fillAndStroke(fillContent: background, fillStyle: FillStyle(eoFill:
                            true), strokeContent: foreground)
        
        Circle()
            .strokeBorder(Color.blue,lineWidth: 4)
            .background(Circle().foregroundColor(Color.red))
            
    }
}

extension Shape {
    /// fills and strokes a shape
    public func fillAndStroke<S:ShapeStyle>(
        fillContent: S,
        fillStyle: FillStyle = FillStyle(),
        strokeContent: S,
        strokeStyle: StrokeStyle = StrokeStyle()
    ) -> some View {
        ZStack {
            self.fill(fillContent, style: fillStyle)
            self.stroke(strokeContent, style: strokeStyle)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 50, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 50))
        path.addLine(to: CGPoint(x: 100, y: 50))
        
        return path
    }
}

struct PathTest_Previews: PreviewProvider {
    static var previews: some View {
        PathTest(foreground: .constant(.red), background: .constant(.blue))
    }
}
