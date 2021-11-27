//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

struct RootView: View {
	@EnvironmentObject private var navigator: Navigator

	var body: some View {
		VStack {
			RootRoutes()
			TabBar()
		}
		.toolbar {
			Button(action: { navigator.goBack() }) {
				Image(systemName: "arrow.left")
			}
			.disabled(!navigator.canGoBack)
		
			Button(action: { navigator.goForward() }) {
				Image(systemName: "arrow.right")
			}
			.disabled(!navigator.canGoForward)
		}
		.onChange(of: navigator.path) { newPath in
			print("Current path:", newPath)
		}
    }
}

// MARK: -
private struct RootRoutes: View {	
	var body: some View {
		SwitchRoutes {
			Route("shortcuts", content: ShortcutsScreen())
			Route("users/*", content: UsersScreen())
			Route {
				Navigate(to: "/users", replace: true)
			}
		}
		.navigationTransition()
	}
}

// MARK: -
private struct TabBar: View {
	@EnvironmentObject private var navigator: Navigator
	
	var body: some View {
		HStack {
			TabBarButton(path: "/users", systemImage: "person.2", title: "User list")
			TabBarButton(path: "/shortcuts", systemImage: "arrow.up.right.square", title: "Shortcuts")
		}
		.font(.system(size: 16))
		.buttonStyle(.plain)
		.frame(height: 70)
	}
	
	private func TabBarButton(path: String, systemImage: String, title: String) -> some View {
		NavLink(to: path) { active in
			VStack {
				Image(systemName: active ? systemImage + ".fill" : systemImage)
					.font(.system(size: 20))
				Text(title)
					.fontWeight(active ? .bold : .regular)
			}
		}
		.frame(maxWidth: .infinity)
	}
}
