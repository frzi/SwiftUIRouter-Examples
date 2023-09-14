//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

// MARK: - Navigation transition view modifier
extension View {
	func navigationTransition() -> some View {
		modifier(NavigationTransition())
	}
}

private struct NavigationTransition: ViewModifier {
	@Environment(Navigator.self) private var navigator
	
	func body(content: Content) -> some View {
		content
			.animation(.smooth(duration: 0.4), value: navigator.lastAction)
			.transition(ScreenTransition(navigator: navigator))
	}
}

private struct ScreenTransition: Transition {
	/// We pass the environment's `Navigator` to the transition so we have the latest, most recent
	/// `NavigationAction.Direction` value, without it being out of date.
	unowned let navigator: Navigator

	private var direction: NavigationAction.Direction {
		navigator.lastAction?.direction ?? .sideways
	}

	func body(content: Content, phase: TransitionPhase) -> some View {
		let goFurther = direction == .deeper
			|| direction == .sideways
			|| navigator.lastAction?.action != .back

		let offset: CGFloat = switch phase {
		case .identity: 0
		case .didDisappear: goFurther ? -200 : 200
		case .willAppear: goFurther ? 400 : -400
		}

		return content
			.offset(x: offset)
			.animation(.smooth, value: phase)
			.overlay(
				Rectangle()
					.fill(Color.black)
					.opacity(phase.isIdentity ? 0 : 0.2)
					.animation(.smooth, value: phase)
			)
	}
}
