//
//  SceneSrorageTest.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2022/02/23.
//

import SwiftUI

struct SceneSrorageTest: View {
    @SceneStorage("selection") var selection:Int?
    
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<5){ index in
                    NavigationLink(
                        destination: Text("Destination \(index)"),
                        tag: index,
                        selection: self.$selection,
                        label: {Text("Navigate \(index)")})
                }
            }.navigationTitle("NavigationView")
        }
        .onChange(of: selection) { newValue in
            if let newValue = newValue {
                print("selection = \(newValue)")
            }
            else {
                print("selection is nil")
            }
        }
    }
}

struct SceneSrorageTest_Previews: PreviewProvider {
    static var previews: some View {
        SceneSrorageTest()
    }
}
