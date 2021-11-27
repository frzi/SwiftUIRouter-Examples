//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import SwiftUI
import SwiftUIRouter

struct UserDetailScreen: View {
	let user: UserModel
	
	var body: some View {
		SwitchRoutes {
			Route("location") {
				UserLocationScreen(location: user.location)
			}
			Route {
				UserDetails(user: user)
			}
		}
	}
}

// MARK: -
private struct UserDetails: View {
	let user: UserModel
	
	var body: some View {
		GeometryReader { _ in
			VStack(alignment: .leading, spacing: 10) {
				HStack(spacing: 20) {
					AsyncImage(url: user.picture.large)
						.cornerRadius(40)
						.frame(width: 140, height: 140)
						
					VStack(alignment: .leading, spacing: 4) {
						Text(user.name.title)
						Text(user.name.first + " " + user.name.last)
							.font(.system(size: 40))
							.fontWeight(.bold)
					}
				}
				
				DetailRow(title: "Email", systemImage: "envelope") {
					Text(user.email)
				}
				
				DetailRow(title: "Date of Birth", systemImage: "calendar") {
					Text(user.dob.date)
				}
				
				DetailRow(title: "Location", systemImage: "pin") {
					NavLink(to: "location") {
						HStack {
							Text(user.location.city + ", " + user.location.country)
							Image(systemName: "chevron.right")
						}
					}
				}
			}
		}
		.padding(20)
	}
	
	private func DetailRow<Content: View>(
		title: String,
		systemImage: String,
		@ViewBuilder content: () -> Content
	) -> some View {
		HStack {
			Label(title, systemImage: systemImage)
				.font(.system(size: 16, weight: .bold))
			Spacer()
			content()
		}
		.font(.system(size: 16))
		.padding(.vertical, 6)
	}
}
