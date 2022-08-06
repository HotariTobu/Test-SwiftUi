//
//  FocusStateMoveView.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2022/02/24.
//

import SwiftUI

struct FocusStateTestView: View {
    private enum FocusStateField: Hashable{
        case firstField
        case secondField
        case noneField
    }
    
    @State private var firstValue = ""
    @State private var secondValue = ""
    
    @FocusState private var focusState: FocusStateField?
    
    var body: some View {
        Form {
            TextField("First", text: $firstValue)
                .focused($focusState, equals: .firstField)
            TextField("Second", text: $secondValue)
                .focused($focusState, equals: .secondField)
            
            // I have tried below...
            EmptyView()
                .focused($focusState, equals: .noneField)
            
            Button("focus on First"){
                focusState = .firstField
            }
            Button("focus on Second"){
                focusState = .secondField
            }
            Button("focus on None"){
                // not work...
                focusState = .noneField
            }
            Button("Close"){
                focusState = nil
            }
        }
        .onChange(of: focusState) { newValue in
            print("focus \(newValue.debugDescription)")
        }
    }
}

struct FocusStateMoveView_Previews: PreviewProvider {
    static var previews: some View {
        FocusStateTestView()
    }
}
