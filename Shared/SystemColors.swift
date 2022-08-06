//
//  SystemColors.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2022/02/24.
//

import SwiftUI

struct SystemColors: View {
    private let colors: [UIColor] = [
        .systemBackground,
        .systemFill,
        .systemGray2,
        .systemGray3,
        .systemGray4,
        .systemGray5,
        .systemGray6,
        .systemGroupedBackground,
        .secondarySystemBackground,
        .quaternarySystemFill,
        .tertiarySystemBackground,
        .secondarySystemFill,
        .secondarySystemGroupedBackground,
        .tertiarySystemFill
    ]
    
    var body: some View {
        VStack {
            ForEach(colors, id: \.self) {
                Color($0)
                    .frame(height: 50)
                    .padding(2)
            }
        }
        .background {
            Color.red
        }
    }
}

struct SystemColors_Previews: PreviewProvider {
    static var previews: some View {
        SystemColors()
    }
}
