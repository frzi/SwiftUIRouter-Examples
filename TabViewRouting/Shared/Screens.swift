//
//  TabViewRouting
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

// MARK: - Different screens
struct MoviesScreen: View {
	var body: some View {
		GeometryReader { _ in
			VStack {
				Text("Movies")
					.font(.title)
				
				NavLink(to: "/Music") {
					Text("Take me to **Music**")
				}
				
				NavLink(to: "/Books") {
					Text("Take me to **Books**")
				}
			}
		}
		.padding()
		#if os(macOS)
		.background(Color.orange)
		#endif
	}
}

struct MusicScreen: View {
	var body: some View {
		GeometryReader { _ in
			VStack {
				Text("Music")
					.font(.title)
				
				NavLink(to: "/Movies") {
					Text("Take me to **Movies**")
				}
				
				NavLink(to: "/Books") {
					Text("Take me to **Books**")
				}
			}
		}
		.padding()
		#if os(macOS)
		.background(Color.yellow)
		#endif
	}
}

struct BooksScreen: View {
	var body: some View {
		GeometryReader { _ in
			VStack {
				Text("Books")
					.font(.title)
				
				NavLink(to: "/Movies") {
					Text("Take me to **Movies**")
				}
				
				NavLink(to: "/Music") {
					Text("Take me to **Music**")
				}
			}
		}
		.padding()
		#if os(macOS)
		.background(Color.green)
		#endif
	}
}
