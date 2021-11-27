//
//  Swiping
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUI
import SwiftUIRouter

// MARK: - Navigation transition
private struct NavigationTransition: ViewModifier {
	@EnvironmentObject private var navigator: Navigator
	
	func body(content: Content) -> some View {
		content
			.animation(.easeInOut, value: navigator.path)
			.transition(
				navigator.lastAction?.direction == .deeper || navigator.lastAction?.direction == .sideways
					? AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
					: AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
			)
	}
}

extension View {
	func navigationTransition() -> some View {
		modifier(NavigationTransition())
	}
}

// MARK: - Swipeable modifier.
/**
 * Modifier to allow draggin from the screen's left edge to go back/up.
 * The current view will move along with the drag gesture, revealing a black background.
 */
struct SwipeableBack: ViewModifier {
	enum Action {
		case back
		case up
	}
	
	@EnvironmentObject private var navigator: Navigator
	@State private var dragOffset: CGFloat = 0
	
	let action: Action
	let threshold: CGFloat
	
	private var dragGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				if (action == .back && navigator.canGoBack && value.startLocation.x < 20)
					|| (action == .up && navigator.path != "/" && value.startLocation.x < 20)
				{
					dragOffset = value.translation.width * 0.2
				}
			}
			.onEnded { value in
				if dragOffset > threshold {
					if action == .back {
						navigator.goBack()
					}
					else if action == .up {
						navigator.navigate("..")
					}
				}
				
				dragOffset = 0
			}
	}
	
	func body(content: Content) -> some View {
		content
			.offset(x: max(0, dragOffset))
			.clipped()
			.background(Color.black)
			.gesture(dragGesture)
	}
}

extension View {
	func swipeableBack(action: SwipeableBack.Action = .back, threshold: CGFloat = 40) -> some View {
		modifier(SwipeableBack(action: action, threshold: threshold))
	}
}

// MARK: - Swipeable modifier (alternative).
/**
 * An alternative effect when swiping from the left edge.
 * Dragging from the edge will render an effect similar to Chrome's back/forward navigation.
 */
struct SwipeableBackAlternative: ViewModifier {
	@EnvironmentObject private var navigator: Navigator
	@State private var dragOffset: CGFloat = 0
	
	let action: SwipeableBack.Action
	let threshold: CGFloat
	private let graphicSize: CGFloat = 200
	
	private var dragGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				if (action == .back && navigator.canGoBack && value.startLocation.x < 20)
					|| (action == .up && navigator.path != "/" && value.startLocation.x < 20)
				{
					dragOffset = value.translation.width * 0.2
				}
			}
			.onEnded { value in
				if dragOffset > threshold {
					if action == .back {
						navigator.goBack()
					}
					else if action == .up {
						navigator.navigate("..")
					}
				}
				
				dragOffset = 0
			}
	}
	
	func body(content: Content) -> some View {
		content
			.overlay(
				ZStack(alignment: .trailing) {
					Circle()
						.fill(.black.opacity(dragOffset / threshold))
					
					Image(systemName: "arrow.right")
						.foregroundColor(.white)
						.font(.system(size: 40))
						.padding(.trailing, 10)
				}
				.frame(width: graphicSize, height: graphicSize)
				.offset(x: min(max(0, dragOffset), graphicSize / 2) - graphicSize),
				alignment: .leading
			)
			.clipped()
			.gesture(dragGesture)
	}
}

extension View {
	func swipeableBackAlt(action: SwipeableBack.Action = .back, threshold: CGFloat = 40) -> some View {
		modifier(SwipeableBackAlternative(action: action, threshold: threshold))
	}
}

