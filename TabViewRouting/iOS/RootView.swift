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
	
	@State private var selected = -1
	
	private let titles: [(title: String, image: String)] = [
		("Movies", "film"),
		("Music", "music.note"),
		("Books", "book"),
	]

	var body: some View {
		TabView(selection: $selected) {
			ForEach(0..<titles.count) { index in
				TabContents()
					.tag(index)
					.tabItem {
						Image(systemName: titles[index].image)
						Text(titles[index].title)
					}
			}
		}
		.onChange(of: selected) { newIndex in
			navigator.navigate("/" + titles[newIndex].title)
		}
		.onChange(of: navigator.path) { newPath in
			let components = newPath.components(separatedBy: "/").dropFirst()
			if let index = titles.firstIndex(where: { $0.title == components.first }) {
				selected = index
			}
		}
		.onAppear {
			if let path = UserDefaults.standard.string(forKey: "path") {
				selected = titles.firstIndex { $0.title == path } ?? 0
			}
			else {
				selected = 0
			}
		}
	}
}

private struct TabContents: View {
	var body: some View {
		SwitchRoutes {
			Route("Movies/*", content: MoviesScreen())
			Route("Music/*", content: MusicScreen())
			Route("Books/*", content: BooksScreen())
		}
		.buttonStyle(.borderedProminent)
	}
}
