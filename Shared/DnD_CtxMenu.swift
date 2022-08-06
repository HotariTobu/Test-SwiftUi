//
//  DnD_CtxMenu.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/24.
//

import SwiftUI

struct DnD_CtxMenu: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
                .simultaneousGesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged { _ in
                                print("drag changed 1a")
                            }
                            .onEnded { _ in
                                print("drag ended 1a")
                            })
                .onTapGesture {
                    print("tap ended 1a")
                }
                .onLongPressGesture(
                    pressing: { isPressed in
                        print("pressing 1a \(isPressed)")
                    }, perform: {
                        print("long press ended 1a")
                    })
                .onAppear {
                    print("appear 1")
                }
                .onDisappear {
                    print("disappear 1")
                }
                .onDrag({NSItemProvider(object: NSString(string: "item"))})
                .onAppear {
                    print("appear 2")
                }
                .onDisappear {
                    print("disappear 2")
                }
                .simultaneousGesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged { _ in
                                print("drag changed 1a")
                            }
                            .onEnded { _ in
                                print("drag ended 1b")
                            })
                .onTapGesture {
                    print("tap ended 1b")
                }
                .onLongPressGesture(
                    pressing: { isPressed in
                        print("pressing 1b \(isPressed)")
                    }, perform: {
                        print("long press ended 1b")
                    })
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
                .simultaneousGesture(DragGesture()
                            .onChanged { _ in
                                print("drag changed 2a")
                            }
                            .onEnded { _ in
                                print("drag ended 2a")
                            })
                .onTapGesture {
                    print("tap ended 2a")
                }
                .onLongPressGesture(
                    pressing: { isPressed in
                        print("pressing 2a \(isPressed)")
                    }, perform: {
                        print("long press ended 2a")
                    })
                .onAppear {
                    print("appear 1")
                }
                .onDisappear {
                    print("disappear 1")
                }
                .onDrag({NSItemProvider(object: NSString(string: "item"))})
                .onAppear {
                    print("appear 2")
                }
                .onDisappear {
                    print("disappear 2")
                }
                .onTapGesture {
                    print("tap ended 2b")
                }
                .contextMenu(ContextMenu(menuItems: {
                    Text("Menu")
                }))
                .onAppear {
                    print("appear 3")
                }
                .onDisappear {
                    print("disappear 3")
                }
                .simultaneousGesture(DragGesture()
                            .onChanged { _ in
                                print("drag changed 2b")
                            }
                            .onEnded { _ in
                                print("drag ended 2b")
                            })
                .onTapGesture {
                    print("tap ended 2c")
                }
                .onLongPressGesture(
                    pressing: { isPressed in
                        print("pressing 2b \(isPressed)")
                    }, perform: {
                        print("long press ended 2b")
                    })
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
                .simultaneousGesture(DragGesture()
                            .onChanged { _ in
                                print("drag changed 3a")
                            }
                            .onEnded { _ in
                                print("drag ended 3a")
                            })
                .onTapGesture {
                    print("tap ended 3a")
                }
                .onLongPressGesture(
                    pressing: { isPressed in
                        print("pressing 3a \(isPressed)")
                    }, perform: {
                        print("long press ended 3a")
                    })
                .onAppear {
                    print("appear 1")
                }
                .onDisappear {
                    print("disappear 1")
                }
                .contextMenu(ContextMenu(menuItems: {
                    Text("Menu")
                }))
                .onAppear {
                    print("appear 2")
                }
                .onDisappear {
                    print("disappear 2")
                }
                .onDrag({NSItemProvider(object: NSString(string: "item"))})
                .onAppear {
                    print("appear 3")
                }
                .onDisappear {
                    print("disappear 3")
                }
                .simultaneousGesture(DragGesture()
                            .onChanged { _ in
                                print("drag changed 3b")
                            }
                            .onEnded { _ in
                                print("drag ended 3b")
                            })
                .onLongPressGesture(
                    pressing: { isPressed in
                        print("pressing 3b \(isPressed)")
                    }, perform: {
                        print("long press ended 3b")
                    })
            Circle()
                .frame(width: 100, height: 100, alignment: .center)
                .itemProvider({
                    NSItemProvider(object: NSString(string: "item"))
                })
                .simultaneousGesture(DragGesture()
                            .onChanged { _ in
                                print("drag changed 4")
                            }
                            .onEnded { _ in
                                print("drag ended 4")
                            })
            List {
                Label("Mustache", systemImage: "mustache")
                    .itemProvider {
                        NSItemProvider(object:  UIImage(systemName: "mustache")!)
                    }
            }
        }
        .background(Color.clear)
        .onDrop(of: [.text], isTargeted: nil, perform: { _ in
            true
        })
        .simultaneousGesture(DragGesture()
                    .onChanged { _ in
                        print("drag changed in  vstack")
                    }
                    .onEnded { _ in
                        print("drag ended in vstack")
                    })
        .onLongPressGesture(
            pressing: { isPressed in
                print("pressing vs \(isPressed)")
            }, perform: {
                print("long press ended vs")
            })
    }
}

struct DnD_CtxMenu_Previews: PreviewProvider {
    static var previews: some View {
        DnD_CtxMenu()
    }
}
