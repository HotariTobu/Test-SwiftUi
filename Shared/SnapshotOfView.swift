//
//  SnapshotOfView.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/25.
//

import SwiftUI

struct SnapshotOfView: View {
    var textView: some View {
        Text("Hello, SwiftUI")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
    
    var body: some View {
        VStack {
            textView
            
            Button("Save to image") {
                let image = textView.snapshot()
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}

struct SnapshotOfView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotOfView()
    }
}
