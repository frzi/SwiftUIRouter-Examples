//
//  RandomUsers App
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

@main
struct RandomUsersApp: App {
	@State private var usersData = UsersData()
	
    var body: some Scene {
        WindowGroup {
			/// (1) This is the first and perhaps the most important step when using SwiftUI Router.
			/// The `Router` view initializes all necessary environment values and objects. Every view in the
			/// SwiftUI Router library works only inside a `Router`.
			///
			/// Although it isn't necessary to put the `Router` at the `App` level, it is recommended to put it as
			/// high as possible in your View hierarchy.
			Router {
				RootView()
			}
			.environment(usersData)
			#if os(macOS)
			.frame(minWidth: 400, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
			#endif
        }
    }
}
