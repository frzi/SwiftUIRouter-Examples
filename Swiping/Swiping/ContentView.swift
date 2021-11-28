//
//  Swiping
//  Created by Freek (github.com/frzi) 2021
//

import SwiftUI
import SwiftUIRouter

struct ContentView: View {
	var body: some View {
		GeometryReader { _ in
			SwitchRoutes {
				Route("one", content: SecondScreen())
					.swipeableBack(action: .up)
				
				Route("one/two", content: ThirdScreen())
					.swipeableBackAlt(action: .up)
				
				Route(content: FirstScreen())
					.swipeableBack(action: .up)
			}
			.ignoresSafeArea(.all, edges: .all)
			.navigationTransition()
			.buttonStyle(.borderedProminent)
		}
	}
}

private struct FirstScreen: View {
	var body: some View {
		VStack {
			Text("First screen")
				.font(.title)
				.padding()
			
			NavLink(to: "one") {
				Text("Go to second screen")
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.orange)
	}
}

private struct SecondScreen: View {
	var body: some View {
		VStack {
			Text("Second screen")
				.font(.title)
				.padding()
			
			Text("Try swiping from the screen's left edge to the right. After dragging beyond a certain threshold, either a `goBack` or `../` (one up) navigation will commit.")
				.padding()
			
			NavLink(to: "two") {
				Text("Go to third screen")
			}
			
			BackButton()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.yellow)
	}
}

private struct ThirdScreen: View {
	var body: some View {
		VStack {
			Text("Third screen")
				.font(.title)
				.padding()
			
			Text("Swiping from the screen's left edge will result in a different effect here! Try it!")
			
			BackButton()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.green)
	}
}

private struct BackButton: View {
	@EnvironmentObject private var navigator: Navigator
	
	var body: some View {
		Button(action: { navigator.goBack() }) {
			Text("Go back")
		}
	}
}
