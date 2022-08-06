//
//  ListSwiftUIModifiers.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/07.
//

import SwiftUI

struct ListSwiftUIModifiers: View {
    var body: some View {
        LazyVStack {
            Text("Effect")
                .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .blendMode(/*@START_MENU_TOKEN@*/.darken/*@END_MENU_TOKEN@*/)
                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .brightness(/*@START_MENU_TOKEN@*/0.60/*@END_MENU_TOKEN@*/)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .clipped()
                .colorMultiply(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .compositingGroup()
                .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .contrast(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .drawingGroup()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .grayscale(/*@START_MENU_TOKEN@*/0.50/*@END_MENU_TOKEN@*/)
                .hoverEffect(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
                .hueRotation(/*@START_MENU_TOKEN@*/Angle(degrees: 90)/*@END_MENU_TOKEN@*/)
                .colorInvert()
                .luminanceToAlpha()
                .mask(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Masking View@*/Text("Masking")/*@END_MENU_TOKEN@*/)
                .matchedGeometryEffect(id: /*@START_MENU_TOKEN@*/"ID"/*@END_MENU_TOKEN@*/, in: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Namespace@*/Namespace().wrappedValue/*@END_MENU_TOKEN@*/)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .projectionEffect(/*@START_MENU_TOKEN@*/ProjectionTransform(.identity)/*@END_MENU_TOKEN@*/)
                .rotation3DEffect(/*@START_MENU_TOKEN@*/Angle(degrees: 90)/*@END_MENU_TOKEN@*/, axis: /*@START_MENU_TOKEN@*/(x: 10.0, y: 10.0, z: 10.0)/*@END_MENU_TOKEN@*/)
                .rotationEffect(/*@START_MENU_TOKEN@*/.zero/*@END_MENU_TOKEN@*/)
                .saturation(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .scaleEffect(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .transformEffect(/*@START_MENU_TOKEN@*/.identity/*@END_MENU_TOKEN@*/)
            Text("Layout")
                .alignmentGuide(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Guide@*/.top/*@END_MENU_TOKEN@*/) { dimension in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
                }
                /*.anchorPreference(key: /*@START_MENU_TOKEN@*/PreferredColorSchemeKey.self/*@END_MENU_TOKEN@*/, value: /*@START_MENU_TOKEN@*/Anchor<CGPoint>.Source.center/*@END_MENU_TOKEN@*/) { anchor in
                 /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                 }*/
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .backgroundPreferenceValue(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Preference Key@*/PreferredColorSchemeKey.self/*@END_MENU_TOKEN@*/) { value in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Background View@*/Color.blue/*@END_MENU_TOKEN@*/
                }
                .coordinateSpace(name: /*@START_MENU_TOKEN@*/CoordinateSpace.local/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .fixedSize()
                .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                .fullScreenCover(isPresented: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                }
                .hidden()
                .ignoresSafeArea()
                .labelsHidden()
                .layoutPriority(/*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                .overlay(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Overlay Content@*/Text("Placeholder")/*@END_MENU_TOKEN@*/)
                .overlayPreferenceValue(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Preference Key@*/PreferredColorSchemeKey.self/*@END_MENU_TOKEN@*/) { value in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Overlay View@*/Color.blue/*@END_MENU_TOKEN@*/
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .position(/*@START_MENU_TOKEN@*/.zero/*@END_MENU_TOKEN@*/)
                .scaledToFill()
                .scaledToFit()
                .transformAnchorPreference(key: /*@START_MENU_TOKEN@*/PreferredColorSchemeKey.self/*@END_MENU_TOKEN@*/, value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Anchor@*/Anchor<CGPoint>.Source.center/*@END_MENU_TOKEN@*/) { (value, anchor) in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            Text("Text")
                .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                //.baselineOffset(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                //.bold()
                .disableAutocorrection(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                .flipsForRightToLeftLayoutDirection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                //.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                //.italic()
                //.kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                //.strikethrough()
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .textContentType(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                //.tracking(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
            //.underline()
            Image(systemName: "heart")
                .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                .resizable()
                .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
            List {
                
            }
            .deleteDisabled(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            .listItemTint(/*@START_MENU_TOKEN@*/.accentColor/*@END_MENU_TOKEN@*/)
            .listRowBackground(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Background View@*/Color.blue/*@END_MENU_TOKEN@*/)
            .listRowInsets(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .moveDisabled(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            NavigationView {
                
            }
            .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            .navigationBarHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
            .navigationTitle(/*@START_MENU_TOKEN@*/"Title"/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct ListSwiftUIModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ListSwiftUIModifiers()
    }
}
