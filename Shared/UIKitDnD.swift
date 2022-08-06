//
//  UIKitDnD.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2021/08/26.
//

import SwiftUI
import UIKit

struct UIKitDnD: View {
    var body: some View {
        VStack {
            ForEach(0...4, id: \.self) { index in
                Color.green
                    .overlay(SomeDndWrapper())
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
    }
}

struct SomeDndWrapper: UIViewRepresentable {
    typealias UIViewType = SomeCustomUIView
    
    func makeUIView(context: Context) -> SomeCustomUIView {
        SomeCustomUIView()
    }
    
    func updateUIView(_ uiView: SomeCustomUIView, context: Context) {
        
    }
}

class SomeCustomUIView: UIView {
    private let dragDelegate: UIDragInteractionDelegate
    private let dropDelegate: UIDropInteractionDelegate
    
    init() {
        dragDelegate = SimpleDragInteractionDelegate()
        dropDelegate = SimpleDropInteractionDelegate()
        
        super.init(frame: .zero)
        
        self.backgroundColor = .red
        self.isUserInteractionEnabled = true
        
        let dragInteraction = UIDragInteraction(delegate: dragDelegate)
        //let dragInteraction = UIDragInteraction(delegate: self)
        // iPhoneの場合はデフォルトがfalseになっている
        dragInteraction.isEnabled = true
        self.addInteraction(dragInteraction)
        
        let dropInteraction = UIDropInteraction(delegate: dropDelegate)
        //let dropInteraction = UIDropInteraction(delegate: self)
        self.addInteraction(dropInteraction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Drag Interactions
class SimpleDragInteractionDelegate: NSObject, UIDragInteractionDelegate {
    override init() {
        print("init drag")
        super.init()
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        print("Drag Begin")
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension SomeCustomUIView: UIDragInteractionDelegate {
    
    /* Provide items to begin a drag.
     *
     * If these items represent things that are displayed in a linear order
     * (for example, rows in a table), provide them in the same order, first
     * to last.
     *
     * If an empty array is returned, then no drag will begin.
     */
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        print("g itemsForBeginning")
        return [UIDragItem(itemProvider: NSItemProvider(object: NSString(string: "The First Item")))]
    }
    
    
    /* Provide a preview to display while lifting the drag item.
     * Return nil to indicate that this item is not visible and should have no lift animation.
     * If not implemented, a UITargetedDragPreview initialized with interaction.view will be used.
     */
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        print("g previewForLifting")
        
        let previewView = UILabel()
        previewView.text = "g previewForLifting"
        previewView.font = .systemFont(ofSize: 42)
        previewView.sizeToFit()
        
        let parameters = UIDragPreviewParameters()
        parameters.backgroundColor = .clear
        parameters.shadowPath = UIBezierPath()
        //parameters.visiblePath = nil
        
        let target = UIDragPreviewTarget(container: self, center: self.center)
        
        return UITargetedDragPreview(view: previewView, parameters: parameters, target: target)
    }
    
    
    /* Called when the lift animation is about to start.
     * Use the animator to animate your own changes alongside the system animation,
     * or to be called when the lift animation completes.
     */
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        print("g willAnimateLiftWith")
    }
    
    
    /* Drag session lifecycle. */
    
    /* Called when the the items are in their fully lifted appearance,
     * and the user has started to drag the items away.
     */
    func dragInteraction(_ interaction: UIDragInteraction, sessionWillBegin session: UIDragSession) {
        print("g sessionWillBegin")
    }
    
    
    /* Return whether this drag allows the "move" drop operation to happen.
     * This only applies to drops inside the same app. Drops in other apps are always copies.
     *
     * If true, then a UIDropInteraction's delegate's -dropInteraction:sessionDidUpdate:
     * may choose to return UIDropOperationMove, and that operation will be provided to
     * -dragInteraction:session:willEndWithOperation: and -dragInteraction:session:didEndWithOperation:.
     *
     * If not implemented, defaults to true.
     */
    func dragInteraction(_ interaction: UIDragInteraction, sessionAllowsMoveOperation session: UIDragSession) -> Bool {
        print("g sessionAllowsMoveOperation")
        return true
    }
    
    
    /* Return whether this drag is restricted to only this application.
     *
     * If true, then the drag will be restricted. Only this application will be
     * able to see the drag, and other applications will not.
     * If the user drops it on another application, the drag will be cancelled.
     *
     * If false, then the drag is not restricted. Other applications may see the drag,
     * and the user may drop it onto them.
     *
     * If not implemented, defaults to false.
     *
     * Note that this method is called only on devices that support dragging across applications.
     */
    func dragInteraction(_ interaction: UIDragInteraction, sessionIsRestrictedToDraggingApplication session: UIDragSession) -> Bool {
        print("g sessionIsRestrictedToDraggingApplication")
        return true
    }
    
    
    /* Return whether this drag's items' previews should be shown in their full
     * original size while over the source view. For instance, if you are reordering
     * items, you may want them not to shrink like they otherwise would.
     *
     * If not implemented, defaults to false.
     */
    func dragInteraction(_ interaction: UIDragInteraction, prefersFullSizePreviewsFor session: UIDragSession) -> Bool {
        print("g prefersFullSizePreviewsFor")
        return true
    }
    
    
    /* Called when the drag has moved (because the user's touch moved).
     * Use -[UIDragSession locationInView:] to get its new location.
     */
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidMove session: UIDragSession) {
        print("g sessionDidMove")
    }
    
    
    /* Called when the user is done dragging, and the drag will finish.
     *
     * If the operation is UIDropOperationCancel or UIDropOperationForbidden,
     * the delegate should prepare its views to show an appropriate appearance
     * before the cancel animation starts.
     */
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, willEndWith operation: UIDropOperation) {
        print("g willEndWith")
    }
    
    
    /* Called when the user is done dragging and all related animations are
     * completed. The app should now return to its normal appearance.
     *
     * If the operation is UIDropOperationCopy or UIDropOperationMove,
     * then data transfer will begin, and -dragInteraction:sessionDidTransferItems: will be called later.
     */
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        print("g didEndWith")
    }
    
    
    /* Called after a drop happened and the handler of the drop has received
     * all of the data that it requested. You may now clean up any extra information
     * relating to those items or their item providers.
     */
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidTransferItems session: UIDragSession) {
        print("g sessionDidTransferItems")
    }
    
    
    /* Adding items to an existing drag. */
    
    /* To allow touches on this view to add items to an existing drag,
     * implement `-dragInteraction:itemsForAddingToSession:withTouchAtPoint:`.
     *
     * If the provided session is an appropriate one to use, then return an array of items,
     * just like in `-dragInteraction:itemsForBeginningSession:`. They will be added to the
     * drag session.
     * Afterwards, `-dragInteraction:session:willAddItems:forInteraction:` will be sent
     * to each interaction which has contributed items to the session, including this one.
     *
     * Otherwise, return an empty array. No items will be added, and the touch
     * will be handled as if the other drag session did not exist.
     *
     * If this method is not implemented, acts as though an an empty array was returned.
     *
     * Use the point, in the view's coordinate space, to determine what part of your view
     * has been touched.
     */
    func dragInteraction(_ interaction: UIDragInteraction, itemsForAddingTo session: UIDragSession, withTouchAt point: CGPoint) -> [UIDragItem] {
        print("g itemsForAddingTo \(point)")
        return [UIDragItem(itemProvider: NSItemProvider(object: NSString(string: "The Added Item")))]
    }
    
    
    /* If there are two or more existing drag sessions, it may not be clear to the user
     * which session items will be added to. Therefore, by default, we do not add to any session.
     *
     * If you *do* want to add the item to a session, implement
     * `-dragInteraction:sessionForAddingItems:withTouchAtPoint:` and return the
     * appropriate session. This should be rare.
     *
     * To continue without adding items, return nil.
     *
     * If this method is not implemented, defaults to nil.
     */
    func dragInteraction(_ interaction: UIDragInteraction, sessionForAddingItems sessions: [UIDragSession], withTouchAt point: CGPoint) -> UIDragSession? {
        print("g sessionForAddingItems: \(point)")
        return nil
    }
    
    
    /* Similar to -dragInteraction:sessionWillBegin:, but for
     * items added to an session after it has already begun.
     *
     * Note that the interaction that is causing the items to be added
     * may be different than the interaction that started the drag.
     * This method is called on the delegates of all interactions that ever added items
     * to this session. `addingInteraction` is the interaction that is causing
     * these new items to be dragged.
     */
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, willAdd items: [UIDragItem], for addingInteraction: UIDragInteraction) {
        print("g addingInteraction")
    }
    
    
    /* Drag cancellation animation. */
    
    /* Called when the drag is cancelled, once for each visible item.
     * Provide a preview to animate the item back to where it belongs.
     * We provide `defaultPreview` which would move the current preview back to where it came from.
     * You may return:
     * - defaultPreview, to use it as-is
     * - nil, to fade the drag item in place
     * - [defaultPreview retargetedPreviewWithTarget:] to move the preview to a different target
     * - a UITargetedDragPreview that you create however you like
     */
    func dragInteraction(_ interaction: UIDragInteraction, previewForCancelling item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
        print("g previewForCancelling")
        
        let previewView = UILabel()
        previewView.text = "g previewForCancelling"
        previewView.font = .systemFont(ofSize: 42)
        previewView.sizeToFit()
        
        let parameters = UIDragPreviewParameters()
        
        let target = UIDragPreviewTarget(container: self, center: self.center)
        
        return UITargetedDragPreview(view: previewView, parameters: parameters, target: target)
    }
    
    
    /* Called when the cancel animation is about to start, once for each item,
     * whether it is visible or not.
     * Use the animator to animate your own changes alongside the system animation.
     */
    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
        print("g willAnimateCancelWith")
    }

}

// MARK: - Drop Interactions
class SimpleDropInteractionDelegate: NSObject, UIDropInteractionDelegate {
    override init() {
        print("init drop")
        super.init()
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print("perform drop")
    }
}

extension SomeCustomUIView: UIDropInteractionDelegate {
    
    
    /* Return whether the delegate is interested in the given session.
     * If this method is not implemented, or if it returns true, then the
     * other delegate methods will be called, starting with `-dropInteraction:sessionDidEnter:`.
     * If it returns false, this interaction will ignore this session. (We may ask again
     * if something significant about the session changes, like the items in it.)
     *
     * Note that returning true does not mean that the delegate definitely *will* accept this drop,
     * just that it *might* want to accept the drop.
     * To accept it, you must also implement `-dropInteraction:sessionDidUpdate:` and return a
     * UIDropProposal with an appropriate operation.
     *
     * This method is commonly used to check whether the session contains any
     * items that this delegate can consume. Use `UIDropSession`'s convenience methods
     * `-hasItemsConformingToTypeIdentifiers:`, `-canLoadObjectsOfClass:`, etc.
     */
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        print("p canHandle")
        return true
    }
    
    
    /* Called when a drag enters the view.
     */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        print("p sessionDidEnter")
    }
    
    
    /* Called when the drag enters the interaction's view, or when when the drag
     * moves while inside the view, or if items are added to the drag while inside the view.
     *
     * You *must* implement this method to accept a drop.
     * Return a `UIDropProposal` that contains the operation that the delegate
     * would like to perform. (Note that you may use `UIDropOperationMove` only if
     * session.allowsMoveOperation is true.)
     *
     * You may also set other properties on the `UIDropProposal` to change the appearance
     * of the drag over this view.
     *
     * Use the session's `-locationInView:` to get a point to use for hit testing.
     */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        print("p sessionDidUpdate")
        return UIDropProposal(operation: .copy)
    }
    
    
    /* Called when the drag has exited the interaction's view.
     */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        print("p sessionDidExit")
    }
    
    
    /* Called when the user drops onto this interaction's view.
     * The delegate should now request data from the session's
     * items' item providers. Data may be requested *only* during
     * the scope of this method.
     */
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print("p performDrop")
    }
    
    
    /* Called when the user has dropped onto this interaction's view,
     * after `-dropInteraction:performDrop:` has been called,
     * and all resulting drop animations have completed.
     *
     * The delegate should cause the interaction's view to draw in its final post-drop state.
     */
    func dropInteraction(_ interaction: UIDropInteraction, concludeDrop session: UIDropSession) {
        print("p concludeDrop")
    }
    
    
    /* When the drag session ends, for any reason, this method will be called
     * for *every* interaction that ever received `-dropInteraction:sessionDidEnter:`,
     * `-dropInteraction:sessionDidUpdate:`, or `-dropInteraction:sessionDidExit:`.
     *
     * If you were keeping track of the session for any reason, you may now forget it.
     */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        print("p sessionDidEnd")
    }
    
    
    /* Drop animation. */
    
    /* Called when the drop happens, after `-dropInteraction:performDrop:`, once for each visible item.
     * Provide a preview to animate the item to where it belongs.
     * We provide `defaultPreview` which would leave the current preview where the item was dropped.
     * You may return:
     * - defaultPreview, to use it as-is
     * - nil, to fade and shrink the drag item in place
     * - [defaultPreview retargetedPreviewWithTarget:] to move the preview to a different target
     * - a UITargetedDragPreview that you create however you like
     */
    func dropInteraction(_ interaction: UIDropInteraction, previewForDropping item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
        print("p previewForDropping")
        
        let previewView = UILabel()
        previewView.text = "g previewForDropping"
        previewView.font = .systemFont(ofSize: 42)
        previewView.sizeToFit()
        
        let parameters = UIDragPreviewParameters()
        
        let target = UIDragPreviewTarget(container: self, center: self.center)
        
        return UITargetedDragPreview(view: previewView, parameters: parameters, target: target)
    }
    
    
    /* Called when the drop animation is about to start, once for each item,
     * whether it is visible or not.
     * Use the animator to animate your own changes alongside the system animation.
     */
    func dropInteraction(_ interaction: UIDropInteraction, item: UIDragItem, willAnimateDropWith animator: UIDragAnimating) {
        print("p willAnimateDropWith")
    }

}

struct UIKitDnD_Previews: PreviewProvider {
    static var previews: some View {
        UIKitDnD()
    }
}
