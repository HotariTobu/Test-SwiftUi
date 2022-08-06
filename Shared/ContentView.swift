//
//  ContentView.swift
//  Shared
//
//  Created by HotariTobu on 2021/08/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Group {
                        NavigationLink(
                            destination: ListSwiftUIViews(),
                            label: {
                                Text("ListSwiftUIViews")
                            })
                        NavigationLink(
                            destination: ListControlModifiers(),
                            label: {
                                Text("ListControlModifiers")
                            })
                        NavigationLink(
                            destination: ListSwiftUIModifiers(),
                            label: {
                                Text("ListSwiftUIModifiers")
                            })
                        NavigationLink(
                            destination: ListSwiftUIEvents(),
                            label: {
                                Text("ListSwiftUIEvents")
                            })
                        NavigationLink(
                            destination: WrappingUIView(),
                            label: {
                                Text("WrappingUIView")
                            })
                        NavigationLink(
                            destination: PathTest(foreground: .constant(.red), background: .constant(.blue)),
                            label: {
                                Text("PathTest")
                            })
                        NavigationLink(
                            destination: WrappedPropertyTest()
                                .environmentObject(ExternalObject1()),
                            label: {
                                Text("WrappedPropertyTest")
                            })
                        NavigationLink(
                            destination: LifeCycleTest(),
                            label: {
                                Text("LifeCycleTest")
                            })
                        NavigationLink(
                            destination: DragAndDrop(),
                            label: {
                                Text("DragAndDrop")
                            })
                        NavigationLink(
                            destination: ReorderTile(),
                            label: {
                                Text("ReorderTile")
                            })
                    }
                    Group {
                        NavigationLink(
                            destination: SimpleLongPressGestureView(),
                            label: {
                                Text("SimpleLongPressGestureView")
                            })
                        NavigationLink(
                            destination: DnD_CtxMenu(),
                            label: {
                                Text("DnD_CtxMenu")
                            })
                        NavigationLink(
                            destination: Gestures(),
                            label: {
                                Text("Gestures")
                            })
                        NavigationLink(
                            destination: UIEvents(),
                            label: {
                                Text("UIEvents")
                            })
                        NavigationLink(
                            destination: CenterBall(),
                            label: {
                                Text("CenterBall")
                            })
                        NavigationLink(
                            destination: GeometryReading(),
                            label: {
                                Text("GeometryReading")
                            })
                        NavigationLink(
                            destination: ScrollViewReading(),
                            label: {
                                Text("ScrollViewReading")
                            })
                        NavigationLink(
                            destination: SnapshotOfView(),
                            label: {
                                Text("SnapshotOfView")
                            })
                        NavigationLink(
                            destination: OnItemDrag(),
                            label: {
                                Text("OnItemDrag")
                            })
                        NavigationLink(
                            destination: MovingRingView(),
                            label: {
                                Text("MovingRingView")
                            })
                    }
                    Group {
                        NavigationLink(
                            destination: CustomDataDnD(),
                            label: {
                                Text("CustomDataDnD")
                            })
                        NavigationLink(
                            destination: UIKitDnD(),
                            label: {
                                Text("UIKitDnD")
                            })
                        NavigationLink(
                            destination: PreviewContextMenu_Content(),
                            label: {
                                Text("PreviewContextMenu")
                            })
                        NavigationLink(
                            destination: ReorderingElements(palette: Palette(colors: (0..<100).map {
                                Color(hue: Double($0) / 100, saturation: 1, brightness: 1)
                            })),
                            label: {
                                Text("ReorderingElements")
                            })
                        NavigationLink(
                            destination: PathTransform(),
                            label: {
                                Text("PathTransform")
                            })
                        NavigationLink(
                            destination: OverridePKCanvas(),
                            label: {
                                Text("OverridePKCanvas")
                            })
                        NavigationLink(
                            destination: Gestures2(),
                            label: {
                                Text("Gestures2")
                            })
                        NavigationLink(
                            destination: GestureRecognizers(),
                            label: {
                                Text("GestureRecognizers")
                            })
                        NavigationLink(
                            destination: PKWithGestures(),
                            label: {
                                Text("PKWithGestures")
                            })
                        NavigationLink(
                            destination: StackViewGesture(),
                            label: {
                                Text("StackViewGesture")
                            })
                    }
                    Group {
                        NavigationLink(
                            destination: DataToParent(),
                            label: {
                                Text("DataToParent")
                            })
                        NavigationLink(
                            destination: VibrationTest(),
                            label: {
                                Text("VibrationTest")
                            })
                        NavigationLink(
                            destination: Notifications(),
                            label: {
                                Text("Notifications")
                            })
                        NavigationLink(
                            destination: ListTextFields(),
                            label: {
                                Text("ListTextFields")
                            })
                        NavigationLink(
                            destination: CodableTest(),
                            label: {
                                Text("CodableTest")
                            })
                        NavigationLink(
                            destination: SceneSrorageTest(),
                            label: {
                                Text("SceneSrorageTest")
                            })
                        NavigationLink(
                            destination: FocusStateTestView(),
                            label: {
                                Text("FocusStateMoveView")
                            })
                    }
                }
            }
        }
    }
}

struct ContentView2: View {
    var body: some View {
        ReorderingElements(palette: Palette(colors: (0..<100).map {
            Color(hue: Double($0) / 100, saturation: 1, brightness: 1)
        }))
    }
}

struct ContentView3: View {
    var body: some View {
        PKSizeTest()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
