//
//  ListControlModifiers.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/15.
//

import SwiftUI

struct ListControlModifiers: View {
    @State var isActionSheetPresented = false
    @State var isAlertPresented = false
    
    @State var isPopoverPresented = false
    @State var isSheetPresented = false
    @State var isStatusBarHidden = true
    
    var body: some View {
        VStack {
            Button("Action Sheet") {
                isActionSheetPresented.toggle()
            }
            .actionSheet(isPresented: $isActionSheetPresented, content: {
                ActionSheet(title: Text("Title"), message: Text("Message"), buttons: [.default(Text("Default")), .cancel(), .destructive(Text("destructive"))])
            })
            Button("Alert") {
                isAlertPresented.toggle()
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("Title"), message: Text("Message"), primaryButton: .default(Text("Primary")), secondaryButton: .destructive(Text("Secondary")))
            }
            Button("Context Menu (Long Tap)") {}
                .contextMenu {
                    Button("Menu Item 1") {}
                    Button("Menu Item 2") {}
                    Button("Menu Item 3") {}
                }
            Button("Item Provier") {}
                .itemProvider {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item@*/nil/*@END_MENU_TOKEN@*/
                }
            Button("Popover") {
                isPopoverPresented.toggle()
            }
            .popover(isPresented: $isPopoverPresented) {
                SomePopupView()
            }
            Button("Sheet") {
                isSheetPresented.toggle()
            }
            .sheet(isPresented: $isSheetPresented) {
                SomePopupView()
            }
            Button("Status Bar") {
                isStatusBarHidden.toggle()
            }
                .statusBar(hidden: isStatusBarHidden)
        }
    }
}

struct SomePopupView: View {
    var body: some View {
        VStack {
            Text("This is a popup")
            DatePicker(selection: .constant(Date())) {
                Text("This is a label")
            }
        }
    }
}

struct ListControlModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ListControlModifiers()
    }
}
