//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUI
import SwiftUIRouter

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
				
				RowButton(path: "/users/" + firstUser.id.uuidString) {
					Text("Go to **\(firstUser.fullName)**'s page")
				}
				
				RowButton(path: "/users/" + secondUser.id.uuidString + "/location") {
					Text("Go to **\(secondUser.fullName)**'s map")
				}
				
				RowButton(path: "/users/fakeuuid") {
					Text("Go to a non-existent user")
				}
				
				RowButton(path: "/foo/bar") {
					Text("Go to `/foo/bar`, a non-existent path.")
				}
			}
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
