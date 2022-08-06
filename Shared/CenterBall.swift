//
//  CenterBall.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/25.
//

import SwiftUI
// 水平方向のScrollViewで球体の大きさを変更するアニメーション
// ※offsetの定義を省略するためにオリジナルのものから少しロジックを改造しております
// https://qiita.com/takaf51/items/a67db8bbc42a4c82b1f0

struct CenterBall: View {
    
    let halfScreenWidth = UIScreen.main.bounds.width / 2
    let magnification: CGFloat = 1.8 // 円の拡大倍率
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0...10, id: \.self) { _ in
                    GeometryReader { geometry in
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.red)
                            // ScrollViewのanimationとしてgeometryReaderの利用が可能
                            // geometory.frame(in: .global).midXで円のx座標の中心点を取得し、
                            // 円が画面の水平方向の中心に来た時にmagnificationで指定した倍率のサイズの
                            // 最大サイズに変更し、左右にずれるほど小さく（最小値は１倍）なるようにサイズを指定
                            //
                            // 円が中心に来たときは、 abs(geometry.frame(in: .global).midX - self.halfScreenWidth)が0となり
                            // 最大値1.8倍で表示する
                            .scaleEffect(
                                max(1,
                                    -abs(geometry.frame(in: .global).midX - self.halfScreenWidth) / self.halfScreenWidth * self.magnification
                                        + self.magnification
                                )
                            )
                    }
                    .frame(width: 100, height: self.magnification * 100)
                    .padding()
                }
            }
        }
    }
}

struct CenterBall_Previews: PreviewProvider {
    static var previews: some View {
        CenterBall()
    }
}
