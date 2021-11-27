//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Foundation
import CoreLocation

struct UserModel: Decodable, Identifiable {
	let dob: DateOfBirth
	let email: String
	let gender: String
	let location: Location
	let login: Login
	let name: Name
	let picture: Picture
	
	// MARK: Computed values.
	var id: UUID { login.uuid }
	var fullName: String {
		name.title + " " + name.first + " " + name.last
	}
	
	// MAKR: -
	struct DateOfBirth: Decodable {
		let age: Int
		let date: String
	}

	struct Location: Decodable {
		let city: String
		let coordinates: Coordinates
		let country: String
		let state: String
		
		struct Coordinates: Decodable {
			let latitude: String
			let longitude: String

			var clLocation: CLLocationCoordinate2D {
				CLLocationCoordinate2D(
					latitude: Double(latitude) ?? 51.532005,
					longitude: Double(longitude) ?? -0.177331
				)
			}
		}
		
		struct Street: Decodable {
			let name: String
			let number: Int
		}
	}
	
	struct Login: Decodable {
		let username: String
		let uuid: UUID
	}
	
	struct Name: Decodable {
		let title: String
		let first: String
		let last: String
	}
	
	struct Picture: Decodable {
		let large: URL
		let medium: URL
		let thumbnail: URL
	}
}
