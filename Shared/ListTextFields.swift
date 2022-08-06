//
//  ListTextFields.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2022/02/19.
//

import SwiftUI

struct ListTextFields: View {
    @State var text = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("asciiCapable", text: $text).keyboardType(.asciiCapable)
                TextField("asciiCapableNumberPad", text: $text).keyboardType(.asciiCapableNumberPad)
                TextField("decimalPad", text: $text).keyboardType(.decimalPad)
                TextField("default", text: $text).keyboardType(.default)
                TextField("emailAddress", text: $text).keyboardType(.emailAddress)
                TextField("namePhonePad", text: $text).keyboardType(.namePhonePad)
            }
            VStack {
                TextField("numbersAndPunctuation", text: $text).keyboardType(.numbersAndPunctuation)
                TextField("numberPad", text: $text).keyboardType(.numberPad)
                TextField("phonePad", text: $text).keyboardType(.phonePad)
                TextField("twitter", text: $text).keyboardType(.twitter)
                TextField("URL", text: $text).keyboardType(.URL)
                TextField("webSearch", text: $text).keyboardType(.webSearch)
            }
            Spacer()
            Button("Reset") {
                text.removeAll()
            }
        }
    }
}

struct ListTextFields_Previews: PreviewProvider {
    static var previews: some View {
        ListTextFields()
    }
}
