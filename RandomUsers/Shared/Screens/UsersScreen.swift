//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUI
import SwiftUIRouter

/// (11) Another view whose only job is to define routes, though this time it comes with some additional logic.
struct UsersScreen: View {
	@Environment(RouteInformation.self) private var routeInformation
	@Environment(UsersData.self) private var usersData

	var body: some View {
		SwitchRoutes {
			/// (12) A route with a parameter (aka a placeholder). The `:uuid` placeholder can be anything.
			/// We use the `validator` option to add an extra layer of validation to our route (see (15)). If the
			/// validator function returns `nil`, the route will be ignored. This time we want to make sure the `:uuid`
			/// placeholder contains a valid UUID as well as make sure the UUID is associated with an actual user.
			/// If the validator found a matching user, said user will be passed down to the child views. We then
			/// render the `UserDetailScreen` view, passing it the user found via the validator.
			Route(":uuid/*", validator: findUser) { user in
				UserDetailScreen(user: user)
			}

			/// (13) If the previous route failed, but the path still contains more components than we need, redirect
			/// the user to the path this view is defined in. (In this case `/users`)
			Route(":anything/*") { route in
				Navigate(to: routeInformation.path)
					.onAppear {
						print("Path \(route.path) doesn't exist. Redirecting to \(routeInformation.path)")
					}
			}
			
			/// (14) Render the default view: `UsersList`.
			Route(content: UsersList())
		}
	}
	
	/// (15) A validator function called by a `Route` (see (12)). It first checks whether the UUID in the path is a
	/// valid UUID. It then checks if there are any users with said UUID. If either checks fail we return `nil`.
	/// If there *is* a user with this UUID, we pass along said user.
	private func findUser(route: RouteInformation) -> UserModel? {
		if let parameter = route.parameters["uuid"],
		   let uuid = UUID(uuidString: parameter)
		{
			return usersData.users.first { $0.id == uuid }
		}
		return nil
	}
}

// MARK: -
private struct UsersList: View {
	@Environment(UsersData.self) private var usersData

	var body: some View {
		List {
			Text("User list")
				.font(.title)

			ForEach(usersData.users) { user in
				UsersListCell(user: user)
			}
		}
		.listStyle(.plain)
		.background(Color.white)
	}

	private func UsersListCell(user: UserModel) -> some View {
		/// (16) Link to `/users/{user uuid}`. Keep in mind that paths in SwiftUI Router are always relative. This
		/// `NavLink` is being rendered inside a `Route` with path `/users/*` (see (6)).
		NavLink(to: user.id.uuidString) {
			HStack {
				AsyncImage(url: user.picture.thumbnail)
					.cornerRadius(20)
					.frame(width: 60, height: 60)
				
				VStack(alignment: .leading, spacing: 7) {
					Text(user.name.first + " " + user.name.last)
						.font(.title2)
					
					Label(user.location.country, systemImage: "location")
				}
				
				Spacer()
				
				Image(systemName: "chevron.right")
			}
			.padding(.vertical, 2)
			.contentShape(Rectangle())
		}
		.buttonStyle(.plain)
		.frame(maxWidth: .infinity)
	}
}
