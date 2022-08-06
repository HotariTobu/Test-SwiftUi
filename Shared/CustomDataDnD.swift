//
//  CustomDataDnD.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/26.
//

import SwiftUI
import UIKit

enum MyError: Error {
    case unknownType
    case generateError
}

final class MyDropData: NSObject, NSItemProviderReading, NSItemProviderWriting {
    static let dragDropID = "public.utf8-plain-text"

    var str: String
    init(_ str:String) {
        self.str = str
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] { [dragDropID] }
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> MyDropData {
        guard typeIdentifier == dragDropID else { throw MyError.unknownType }
        if let str = String(data: data, encoding: .utf8) {
            return MyDropData(str)
        }
        throw MyError.generateError
    }

    static var writableTypeIdentifiersForItemProvider: [String] { [dragDropID as String] }
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let data = str.data(using: .utf8)
        completionHandler(data, nil)
        return nil
    }
}
struct CustomDataDnD: View {
    @State private var dragText1 = "Drag from"
    @State private var dragText2 = "Drag from"
    @State private var dropText1 = "Drop to"
    @State private var dropText2 = "Drop to"

    @State private var isTarget1 = false
    @State private var isTarget2 = false
    var body: some View {
        HStack {
            List {
                Text(dragText1)
                    .onDrag {
                        let provider = NSItemProvider()
                        provider.registerDataRepresentation(forTypeIdentifier: "public.plain-text", visibility: .all) { (completion) -> Progress? in
                            completion(dragText1.data(using: .utf8), nil)
                            return nil
                        }
                        return provider
                    }
                Text(dragText2)
                    .onDrag  {
                        return NSItemProvider(object: MyDropData(dragText2))
                    }
            }
            List {
                Text(dropText1)
                    .onDrop(of: ["public.plain-text"], isTargeted: $isTarget1) { providers -> Bool in
                        guard let provider = providers.first else { return false }
                        guard provider.hasItemConformingToTypeIdentifier("public.plain-text") else { return false }
                        provider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { (data, error) in
                            if let str = String(data: data as! Data, encoding: .utf8) {
                                dropText1 += " \(str)"
                            }
                        }
                        return true

                    }
                Text(dropText2)
                    .onDrop(of: MyDropData.readableTypeIdentifiersForItemProvider, isTargeted: $isTarget2) { providers -> Bool in
                        guard let provider = providers.first else { return false }
                        guard provider.canLoadObject(ofClass: MyDropData.self) else { return false }
                        provider.loadObject(ofClass: MyDropData.self) { (data, error) in
                            if let myDropData = data as? MyDropData {
                                dropText2 += " \(myDropData.str)"
                            }
                        }
                        return true
                    }
            }
        }
    }
}

struct CustomDataDnD_Previews: PreviewProvider {
    static var previews: some View {
        CustomDataDnD()
    }
}
