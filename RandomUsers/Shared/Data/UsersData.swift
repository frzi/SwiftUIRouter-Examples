//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Combine
import Foundation

/// This code is unimportant and unrelated to the workings of SwiftUI Router.
/// `UsersData` simply holds all the data we use throughout the app (loaded from a single JSON found in the bundle).
/// We use an `ObservableObject` as an environment object as singletons (shared instances) are generally discouraged
/// when working with data in SwiftUI.
final class UsersData: ObservableObject {
	@Published private(set) var users: [UserModel]
	
	init() {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		struct RandomUsersAPIResponse: Decodable {
			let results: [UserModel]
		}
		
		do {
			guard let jsonPath = Bundle.main.url(forResource: "randomusers", withExtension: "json") else {
				fatalError("Unable to load randomusers.json")
			}
			
			let jsonData = try Data(contentsOf: jsonPath)
			let json = try decoder.decode(RandomUsersAPIResponse.self, from: jsonData)
			users = json.results.sorted { left, right in
				left.name.last < right.name.last
			}
		}
		catch {
			print(error)
			fatalError()
		}
	}
}
