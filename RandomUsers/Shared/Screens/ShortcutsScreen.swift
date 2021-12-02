//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUI
import SwiftUIRouter

/// (18) This screen was added to demonstrate how easy it is to navigate to another parth of the app, as well as the
/// results of navigating to a path that doesn't exist, or isn't valid
struct ShortcutsScreen: View {
	@EnvironmentObject private var usersData: UsersData
		
	var body: some View {
		let firstUser = usersData.users[0]
		let secondUser = usersData.users[1]
		
		return GeometryReader { _ in
			List {
				Text("Shortcuts")
					.font(.title)
				
				Text(
					"""
					This screen demonstrates the flexibility of working with path-based routing.
					Below are several links to different screens.
					"""
				)
				.font(.body)
				
				/// Navigates to the detail screen of a user.
				RowButton(path: "/users/" + firstUser.id.uuidString) {
					Text("Go to **\(firstUser.fullName)**'s page")
				}
				
				/// Navgiates to the map screen (`UserLocationScreen`) of a user. A screen that, hierarchy wise, is
				/// several layers deep. Yet, with a single path we can navigate to it, effortlessly!
				RowButton(path: "/users/" + secondUser.id.uuidString + "/location") {
					Text("Go to **\(secondUser.fullName)**'s map")
				}
				
				/// Navigates to a user that doesn't exist. In `UsersScreen` we programmed a fallback for invalid paths
				/// to users (see (12), (13) and (14)).
				RowButton(path: "/users/fakeuuid") {
					Text("Go to a non-existent user")
				}
				
				/// Navigates to a path that's completely non-existent. In `RootRoutes` we programmed a fallback route
				/// that redirects the user back to `/users` (see (7)).
				RowButton(path: "/foo/bar") {
					Text("Go to `/foo/bar`, a non-existent path.")
				}
			}
			.listStyle(.plain)
		}
	}
	
	private func RowButton<Content: View>(path: String, @ViewBuilder content: @escaping () -> Content) -> some View {
		NavLink(to: path) {
			HStack {
				content()
				Spacer()
				Image(systemName: "chevron.right")
			}
			.padding(.vertical, 6)
		}
		.buttonStyle(.bordered)
		.frame(maxWidth: .infinity)
	}
}
