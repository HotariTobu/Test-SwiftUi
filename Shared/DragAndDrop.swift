//
//  DragAndDrop.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/19.
//

import SwiftUI

struct DragAndDrop: View {
    @State private var operation = DropOperation.copy
    
    var body: some View {
        VStack {
            Picker(selection: $operation, label: Text("Operations"), content: {
                Text("Cancel").tag(DropOperation.cancel)
                Text("Copy").tag(DropOperation.copy)
                Text("Forbidden").tag(DropOperation.forbidden)
                Text("Move").tag(DropOperation.move)
            })
            LazyVGrid(columns: [GridItem(.fixed(200)), GridItem(.fixed(200))], content: {
                ForEach(0 ..< 6) { index in
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding()
                        .onDrag({
                            NSItemProvider(object: NSString(string: String(index)))
                        })
                }
            })
            .background(Color(white: 0.9))
            .onDrop(of: ["text"], delegate: SomeDropDelegate(operation: operation))
        }
    }
}

struct SomeDropDelegate: DropDelegate {
    let operation: DropOperation
    
    func dropEntered(info: DropInfo) {
        print("entered: \(info.location.debugDescription)")
    }
    
    func dropExited(info: DropInfo) {
        print("exited: \(info.location.debugDescription)")
    }
    
    /*func dropUpdated(info: DropInfo) -> DropProposal? {
        var operation: DropOperation
        switch Int.random(in: 0 ... 3) {
        case 0: operation = .cancel
        case 2: operation = .forbidden
        case 3: operation = .move
        default: operation = .copy
        }
        print("updated: \(operation)  \(info.location.debugDescription)")
        return DropProposal(operation: operation)
    }*/
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("updated: \(info.location.debugDescription)")
        return DropProposal(operation: operation)
    }
    
    func validateDrop(info: DropInfo) -> Bool {
        let result = Bool.random()
        print("validate: \(result)  \(info.location.debugDescription)")
        return result
    }
    
    func performDrop(info: DropInfo) -> Bool {
        let result = Bool.random()
        print("perform: \(result)  \(info.location.debugDescription)")
        return result
    }
}

struct DragAndDrop_Previews: PreviewProvider {
    static var previews: some View {
        DragAndDrop()
    }
}
