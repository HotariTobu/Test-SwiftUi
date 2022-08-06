//
//  ReorderingItems.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/27.
//

import SwiftUI

protocol ReorderableElement: Identifiable, Equatable {
    var id: UUID { get }
}

protocol ReorderableData: ObservableObject {
    associatedtype Element: ReorderableElement
    var array: [Element] { get set }
    var draggingId: UUID { get set }
}

class ReorderingDnDHost: UIView {
    var onSnapshot = { UIImage() }
    
    private let onDragBegun: () -> Void
    private let onDragEnded: () -> Void
    private let onDropEntered: () -> Void

    private var previewView = UIImageView()
    private let previewParameters = UIDragPreviewParameters()
    private lazy var previewTarget = UIDragPreviewTarget(container: self, center: self.center)

    init(onDragBegun: @escaping () -> Void, onDragEnded: @escaping () -> Void, onDropEntered: @escaping () -> Void) {
        self.onDragBegun = onDragBegun
        self.onDragEnded = onDragEnded
        self.onDropEntered = onDropEntered

        super.init(frame: .zero)

        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true

        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        self.addInteraction(dragInteraction)

        let dropInteraction = UIDropInteraction(delegate: self)
        self.addInteraction(dropInteraction)

        previewParameters.backgroundColor = .clear
        previewParameters.shadowPath = UIBezierPath()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReorderingDnDHost: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        previewView = UIImageView(image: onSnapshot())
        previewView.layer.shadowColor = UIColor.lightGray.cgColor
        previewView.layer.shadowRadius = 5
        
        return [UIDragItem(itemProvider: NSItemProvider())]
    }

    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        previewView.layer.shadowOpacity = 1

        return UITargetedDragPreview(view: previewView, parameters: previewParameters, target: previewTarget)
    }

    func dragInteraction(_ interaction: UIDragInteraction, sessionAllowsMoveOperation session: UIDragSession) -> Bool {
        onDragBegun()
        return true
    }

    func dragInteraction(_ interaction: UIDragInteraction, previewForCancelling item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
        previewView.layer.shadowOpacity = 0

        return UITargetedDragPreview(view: previewView, parameters: previewParameters, target: previewTarget)
    }

    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        onDragEnded()
    }
}

extension ReorderingDnDHost: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        onDropEntered()
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .cancel)
    }
}

struct ReorderingHost<Data: ReorderableData>: UIViewRepresentable {
    typealias UIViewType = ReorderingDnDHost

    let data: Data
    let elementId: UUID
    let onSnapshot: () -> UIImage

    func makeUIView(context: Context) -> ReorderingDnDHost {
        ReorderingDnDHost(onDragBegun: {
            data.draggingId = elementId
        }, onDragEnded: {
            data.draggingId = UUID()
        }, onDropEntered: {
            guard data.draggingId != elementId else {
                return
            }

            let _from = data.array.firstIndex {
                $0.id == data.draggingId
            }
            let _to = data.array.firstIndex {
                $0.id == elementId
            }

            guard let from = _from, let to = _to else {
                return
            }

            withAnimation {
                data.array.move(fromOffsets: IndexSet(integer: from), toOffset: to + (from < to ? 1 : 0))
            }
        })
    }

    func updateUIView(_ uiView: ReorderingDnDHost, context: Context) {
        uiView.onSnapshot = onSnapshot
    }
}

extension View {
    func snapshot() -> UIImage {
        let _view = UIHostingController(rootView: self).view

        guard let view = _view else {
            return UIImage()
        }

        let targetSize = view.intrinsicContentSize
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }

    func reorderable<Data: ReorderableData>(data: Data, elementId: UUID) -> some View {
        self
            .opacity(data.draggingId == elementId ? 0 : 1)
            .overlay(
                ReorderingHost(data: data, elementId: elementId) {
                    self
                        .padding(10)
                        .snapshot()
                }
            )
    }
}

// MARK: - カスタマイズする部分

struct ColorElement: ReorderableElement {
    let id = UUID()
    let color: Color
}

class Palette: ReorderableData {
    @Published var array: [ColorElement]
    @Published var draggingId = UUID()
    
    init(colors: [Color]) {
        self.array = colors.map {
            ColorElement(color: $0)
        }
    }
}

struct ReorderingElements: View {
    @ObservedObject var palette: Palette
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(80)), count: 4), spacing: nil) {
                ForEach(palette.array) { colorData in
                    Circle()
                        .fill(colorData.color)
                        .frame(width: 50, height: 50)
                        .reorderable(data: palette, elementId: colorData.id)
                        .padding()
                        .onAppear {
                            if palette.draggingId == colorData.id {
                                print("あ!")
                            }
                        }
                        .onDisappear {
                            if palette.draggingId == colorData.id {
                                print("あ...")
                            }
                        }
                }
            }
        }
    }
}

struct ReorderingElements2: View {
    @ObservedObject var palette: Palette
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(80)), count: 4), spacing: nil) {
                ForEach(palette.array) { colorData in
                    Circle()
                        .fill(colorData.color)
                        .frame(width: 50, height: 50)
                        .onDrag({ NSItemProvider() })
                        .padding()
                        .onAppear {
                            if palette.draggingId == colorData.id {
                                print("あ!")
                            }
                        }
                        .onDisappear {
                            if palette.draggingId == colorData.id {
                                print("あ...")
                            }
                        }
                }
            }
        }
    }
}

struct ReorderingElements_Previews: PreviewProvider {
    static var previews: some View {
        ReorderingElements(palette: Palette(colors: (0..<100).map {
            Color(hue: Double($0) / 100, saturation: 1, brightness: 1)
        }))
    }
}
