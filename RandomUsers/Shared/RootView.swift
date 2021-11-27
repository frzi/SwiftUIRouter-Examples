//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

struct RootView: View {
	@EnvironmentObject private var navigator: Navigator
	
	@ViewBuilder
	private func toolbarContents() -> some View {
		Button(action: { navigator.goBack(total: 2) }) {
			Image(systemName: "arrow.left")
		}
		.disabled(!navigator.canGoBack)
	
		Button(action: { navigator.goForward() }) {
			Image(systemName: "arrow.right")
		}
		.disabled(!navigator.canGoForward)
		
		Button(action: { navigator.clear() }) {
			Image(systemName: "clear")
		}
		.disabled(!navigator.canGoBack && !navigator.canGoForward)
	}

	var body: some View {
		VStack {
			#if os(iOS)
			HStack {
				Spacer()
				toolbarContents()
					.buttonStyle(.borderedProminent)
			}
			.padding(.horizontal, 20)
			#endif
			/// (2) Render the top level routes. See (3).
			RootRoutes()
			TabBar()
		}
		#if os(macOS)
		.toolbar {
			toolbarContents()
		}
		#endif
		/// To better keep track of the current path we'll print it to the console every time it changes.
		/// This would also be a great time to store the current path to UserDefaults/AppStore, or send it to a
		/// backend for analytic reasons.
		.onChange(of: navigator.path) { newPath in
			print("Current path:", newPath)
		}
    }
}

// MARK: - Routes
/// (3) The only purpose of this view is to determine what to render for which paths.
/// By using a simple view like this we can better separate our routing logic, without obfuscating it with unrelated
/// code.
private struct RootRoutes: View {	
	var body: some View {
		/// (4) A `SwitchRoutes` is like a `switch`, but for routes. Only the first matching `Route` will be rendered.
		/// This allows you to create 'fallback' routes (shown below), as well as gain potentional performance boost:
		/// once a route has been matched, any following routes can immediately skip any work on path matching.
		SwitchRoutes {
			/// (5) The first defined route. If the current path is `/shortcuts`, the `ShortcutsScreen` view will be
			/// rendered. Note the lack of `/` in the defined path. This is due to all paths in SwiftUI Router being
			/// relative to any parent routes.
			Route("shortcuts", content: ShortcutsScreen())
			
			/// (6) A wildcard (`*`) is used in this path to indicate this route should also render `UsersScreen` for
			/// deeper paths (e.g. `/users/foobar/etc`). We will handle the routing logic for deeper paths in
			/// `UsersScreen`.
			Route("users/*", content: UsersScreen())
			
			/// (7) By default a `Route` has `*` as its path, meaning it will always match, regardless of the current
			/// path. However, since this route is declared in a `SwitchRoutes`, once a preceding route has already
			/// matched this route will get ignored. This route is a so-called 'fallback route'. You can use this
			/// to show a "404 not found" message. Or redirect to another path; as shown below:
			Route {
				/// (8) Immediately redirect the user to `/users` once this view is rendered. An alternative could be
				/// to render an error message.
				Navigate(to: "/users", replace: true)
			}
		}
		.navigationTransition()
	}
}

// MARK: - Custom Tab bar
/// (9) Because SwiftUI Router uses its own states for navigation it's not made to work with SwiftUI's builtin TabView.
/// Though one can get both TabView and SwiftUI Router to work together, with a little bit of extra code.
/// However, in the interest of keeping things straightforward, we use custom tab bar to utilize SwiftUI Router's
/// `NavLink` button.
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
		/// (10) A `NavLink` is a wrapper around a Button that, when pressed, will navigate to the given path.
		/// A `NavLink` passes down a `Bool` to its child views to indicate whether its path matches that of the current
		/// path. This gives you the opportunity to stylize your `NavLink`s accordingly.
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
