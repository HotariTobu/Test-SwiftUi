//
//  StackViewGesture.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/09/02.
//

import SwiftUI

struct StackViewGesture: View {
    var body: some View {
        VStack {
            ZStack {
                Color.red
                    .onTapGesture {
                        print("red")
                    }
                Color.clear
                    .onTapGesture {
                        print("clear")
                    }
            }
            ZStack {
                Color.green
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded {
                                print("green")
                            }
                    )
                Color.clear
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded {
                                print("clear")
                            }
                    )
            }
            Color.orange
                .onTapGesture {
                    print("orange")
                }
                .overlay(
                    Color.clear
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    print("overlay")
                                }
                        )
                )
                .background(
                    Color.gray
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    print("background")
                                }
                        )
                )
        }
    }
}

struct StackViewGesture_Previews: PreviewProvider {
    static var previews: some View {
        StackViewGesture()
    }
}
