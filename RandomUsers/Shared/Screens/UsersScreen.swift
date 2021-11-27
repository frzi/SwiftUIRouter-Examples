//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUIRouter
import SwiftUI

struct UsersScreen: View {
	@EnvironmentObject private var usersData: UsersData
	@EnvironmentObject private var routeInformation: RouteInformation

	private func findUser(route: RouteInformation) -> UserModel? {
		if let parameter = route.parameters["uuid"],
		   let uuid = UUID(uuidString: parameter)
		{
			return usersData.users.first { $0.id == uuid }
		}
		return nil
	}
	
	var body: some View {
		SwitchRoutes {
			Route(":uuid/*", validator: findUser) { user in
				UserDetailScreen(user: user)
			}
			Route(":anything/*") {
				Navigate(to: routeInformation.path)
			}
			Route(content: UsersList())
		}
	}
}

// MARK: -
private struct UsersList: View {
	@EnvironmentObject private var usersData: UsersData
	
	var body: some View {
		List {
			Text("User list")
				.font(.title)

			ForEach(usersData.users) { user in
				UsersListCell(user: user)
			}
		}
	}
	
	private func UsersListCell(user: UserModel) -> some View {
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
		}
		.buttonStyle(.plain)
		.frame(maxWidth: .infinity)
	}
}
