//
//  ListSwiftUIEvents.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/07.
//

import SwiftUI

struct ListSwiftUIEvents: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            .onChange(of: /*@START_MENU_TOKEN@*/"Value"/*@END_MENU_TOKEN@*/) { value in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            .onContinueUserActivity(/*@START_MENU_TOKEN@*/"Activity"/*@END_MENU_TOKEN@*/) { userActivity in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            /*.onDelete { indexSet in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }*/
            .onDisappear {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            .onDrag { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item Provider@*/NSItemProvider()/*@END_MENU_TOKEN@*/ }
            .onDrop(of: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Types@*/[.plainText]/*@END_MENU_TOKEN@*/, isTargeted: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is Targeted@*/.constant(false)/*@END_MENU_TOKEN@*/) { providers in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/true/*@END_MENU_TOKEN@*/
            }
            .onHover { hovering in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            /*.onInsert(of: /*@START_MENU_TOKEN@*/[.plainText]/*@END_MENU_TOKEN@*/) { index, items in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            .onMove { indices, newOffset in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }*/
            .onOpenURL { url in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            .onPreferenceChange(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Preference Key@*/PreferredColorSchemeKey.self/*@END_MENU_TOKEN@*/) { value in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            }
            .onReceive(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Publisher@*/NotificationCenter.default.publisher(for: .NSCalendarDayChanged)/*@END_MENU_TOKEN@*/) { _ in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=code@*/ /*@END_MENU_TOKEN@*/
            }
    }
}

struct ListSwiftUIEvents_Previews: PreviewProvider {
    static var previews: some View {
        ListSwiftUIEvents()
    }
}
