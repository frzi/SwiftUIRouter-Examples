//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import Combine
import Foundation

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
			users = json.results
		}
		catch {
			print(error)
			fatalError()
		}
	}
}
