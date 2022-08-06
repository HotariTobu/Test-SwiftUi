//
//  ReorderTile.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/19.
//

import SwiftUI
import UniformTypeIdentifiers

struct ReorderTile: View {
    var body: some View {
        DemoDragRelocateView()
    }
}

struct ReorderTile_Previews: PreviewProvider {
    static var previews: some View {
        ReorderTile()
    }
}

struct GridData: Identifiable, Equatable {
    let id: Int
    let color: Color
}

//MARK: - Model

class Model: ObservableObject {
    @Published var data: [GridData]

    let columns = [
        GridItem(.fixed(160)),
        GridItem(.fixed(160))
    ]

    init() {
        data = Array(repeating: GridData(id: 0, color: .clear), count: 100)
        for i in 0..<data.count {
            data[i] = GridData(id: i, color: Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
        }
    }
}

//MARK: - Grid

struct DemoDragRelocateView: View {
    @StateObject private var model = Model()

    @State private var dragging: GridData?

    var body: some View {
        ScrollView {
           LazyVGrid(columns: model.columns, spacing: 32) {
                ForEach(model.data) { d in
                    GridItemView(d: d)
                        //.overlay( Color.white.opacity(0.8) : Color.clear)
                        .opacity(dragging?.id == d.id ? 0 : 1)
                        .onDrag {
                            self.dragging = d
                            return NSItemProvider(object: String(d.id) as NSString)
                        }
                        .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: d, listData: $model.data, current: $dragging))
                }
            }.animation(.default, value: model.data)
        }
        .onDrop(of: [UTType.text], delegate: DropOutsideDelegate(current: $dragging))
        .frame(width: 300, height: 500, alignment: .center)
    }
}

struct DragRelocateDelegate: DropDelegate {
    let item: GridData
    @Binding var listData: [GridData]
    @Binding var current: GridData?

    func dropEntered(info: DropInfo) {
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return false
    }
}

//MARK: - GridItem

struct GridItemView: View {
    var d: GridData

    var body: some View {
        VStack {
            Text(String(d.id))
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 160, height: 240)
        .background(d.color)
    }
}

struct DropOutsideDelegate: DropDelegate {
    @Binding var current: GridData?
        
    func performDrop(info: DropInfo) -> Bool {
        current = nil
        return true
    }
}
