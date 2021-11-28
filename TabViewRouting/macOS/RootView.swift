//
//  TabViewRouting
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

extension String: Identifiable {
	public var id: String { self }
}

struct RootView: View {
	@EnvironmentObject private var navigator: Navigator
	
	@State private var selected: String?
	
	private let titles: [(title: String, image: String)] = [
		("Movies", "film"),
		("Music", "music.note"),
		("Books", "book"),
	]
	
    var body: some View {
		NavigationView {
			List(selection: $selected) {
				ForEach(titles, id: \.title) { (title, icon) in
					HStack {
						Image(systemName: icon)
							.foregroundColor(Color.primary)
							.frame(width: 22	)
						
						Text(title)
					}
				}
			}
			.listStyle(.sidebar)
			.frame(minWidth: 200)
			.navigationTitle("")
			
			ContentView()
				.toolbar {
					Text("Path: " + navigator.path)
				}
		}
		.onChange(of: selected) { newSelected in
			let pathComponents = navigator.path.components(separatedBy: "/").dropFirst()
			if newSelected != pathComponents.first {
				navigator.navigate("/" + (newSelected ?? ""))
			}
		}
		.onChange(of: navigator.path) { newPath in
			let components = newPath.components(separatedBy: "/").dropFirst()
			if selected != components.first {
				selected = components.first
			}

			UserDefaults.standard.set(navigator.path, forKey: "path")
		}
		.onAppear {
			if let path = UserDefaults.standard.string(forKey: "path") {
				print("Going to \(path) on launch")
				navigator.navigate(path)
			}
		}
    }
}

// MARK: - Routes
private struct ContentView: View {
	var body: some View {
		SwitchRoutes {
			Route("Movies/*", content: MoviesScreen())
			Route("Music/*", content: MusicScreen())
			Route("Books/*", content: BooksScreen())
		}
	}
}
