//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUI
import SwiftUIRouter

// MARK: - Navigation transition view modifier
extension View {
	func navigationTransition() -> some View {
		modifier(NavigationTransition())
	}
}

private struct NavigationTransition: ViewModifier {
	@EnvironmentObject private var navigator: Navigator
	
	private func transition(for direction: NavigationAction.Direction?) -> AnyTransition {
		if direction == .deeper || direction == .sideways {
			return AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
		}
		else {
			return AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
		}
	}
	
	func body(content: Content) -> some View {
		content
			.animation(.easeInOut, value: navigator.path)
			.transition(transition(for: navigator.lastAction?.direction))
	}
}

// MARK: - Swipeable modifier.
/**
 * Modifier to allow swiping right for going back / up.
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
					|| (action == .up && navigator.path != "/")
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
