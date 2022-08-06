//
//  ReorderTile3.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/22.
//

import SwiftUI

struct GridData2: Identifiable, Equatable {
    let id: String
}

//MARK: - Model2

class Model2: ObservableObject {
    @Published var data: [GridData2]

    let columns = [
        GridItem(.flexible(minimum: 60, maximum: 60))
    ]

    init() {
        data = Array(repeating: GridData2(id: "0"), count: 50)
        for i in 0..<data.count {
            data[i] = GridData2(id: String("\(i)"))
        }
    }
}

//MARK: - Grid

struct DemoDragRelocateView2: View {
    @StateObject private var model = Model2()

    @State private var dragging: GridData2? // I can't reset this when user drops view ins ame location as drag started
    @State private var changedView: Bool = false

    var body: some View {
        VStack {
            ScrollView(.vertical) {
               LazyVGrid(columns: model.columns, spacing: 5) {
                    ForEach(model.data) { d in
                        GridItemView2(d: d)
                            .opacity(dragging?.id == d.id && changedView ? 0 : 1)
                            .onDrag {
                                self.dragging = d
                                changedView = false
                                return NSItemProvider(object: String(d.id) as NSString)
                            }
                            .onDrop(of: [.text], delegate: DragRelocateDelegate2(item: d, listData: $model.data, current: $dragging, changedView: $changedView))
                            
                    }
                }.animation(.default, value: model.data)
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.gray.edgesIgnoringSafeArea(.all))
        .onDrop(of: [.text], delegate: DropOutsideDelegate2(current: $dragging, changedView: $changedView))
    }
}

struct DragRelocateDelegate2: DropDelegate {
    let item: GridData2
    @Binding var listData: [GridData2]
    @Binding var current: GridData2?
    @Binding var changedView: Bool
    
    func dropEntered(info: DropInfo) {
        
        if current == nil { current = item }
        
        changedView = true
        
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
        changedView = false
        self.current = nil
        return true
    }
    
}

struct DropOutsideDelegate2: DropDelegate {
    @Binding var current: GridData2?
    @Binding var changedView: Bool
        
    func dropEntered(info: DropInfo) {
        changedView = true
    }
    func performDrop(info: DropInfo) -> Bool {
        changedView = false
        current = nil
        return true
    }
}

//MARK: - GridItem

struct GridItemView2: View {
    var d: GridData2

    var body: some View {
        VStack {
            Text(String(d.id))
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 60)
        .background(Circle().fill(Color.green))
    }
}

struct ReorderTile3: View {
    var body: some View {
        DemoDragRelocateView2()
    }
}

struct ReorderTile3_Previews: PreviewProvider {
    static var previews: some View {
        ReorderTile3()
    }
}
