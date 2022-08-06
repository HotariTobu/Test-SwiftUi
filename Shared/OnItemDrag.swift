//
//  OnItemDrag.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/25.
//

import SwiftUI

struct OnItemDrag: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .pink, .purple, .gray]
    
    @State private var scrollOffset = CGSize.zero
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<8, id: \.self) { index in
                    Circle()
                        .fill(colors[index])
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
        }
        .content.offset(scrollOffset)
    }
}

struct DraggableView<Content: View>: View {
    @State private var isDragging = false
    @State private var offset = CGSize.zero
    
    let content: () -> Content
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.2)
            .onChanged { isPressed in
                print("long: \(isPressed)")
            }
            .onEnded { isPressed in
                withAnimation {
                    isDragging = isPressed
                }
            }
        
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { info in
                if isDragging {
                    offset = info.translation
                }
            }
            .onEnded { _ in
                withAnimation {
                    isDragging = false
                    offset = CGSize.zero
                }
            }
        
        content()
            .scaleEffect(isDragging ? 1.1 : 1)
            .shadow(color: .black, radius: isDragging ? 10 : 0)
            .offset(offset)
            .simultaneousGesture(longPressGesture)
            .simultaneousGesture(dragGesture)
    }
}

struct CustomScrollView<Content: View>:
    UIViewRepresentable {
    
    typealias UIViewType = UIScrollView
    
    let content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        UIScrollView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
    }
}

struct OnItemDrag_Previews: PreviewProvider {
    static var previews: some View {
        OnItemDrag()
    }
}
