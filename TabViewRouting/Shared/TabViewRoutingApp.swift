//
//  TabViewRouting
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

@main
struct TabViewRoutingApp: App {
    var body: some Scene {
        WindowGroup {
			Router {
				RootView()
			}
        }
    }
}
