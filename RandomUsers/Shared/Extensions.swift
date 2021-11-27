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
