//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

@main
struct RandomUsersApp: App {
	@StateObject private var usersData = UsersData()
	
    var body: some Scene {
        WindowGroup {
			Router {
				RootView()
			}
			.environmentObject(usersData)
			#if os(macOS)
			.frame(minWidth: 400, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
			#endif
        }

    }
}
