//
//  ContentView.swift
//  CustomProgressBarDemo
//
//  Created by Marlon Raskin on 8/19/20.
//

import SwiftUI

struct ProgressBarDemo: View {

	@State private var circleProgress: AsyncImageProgress = .determinate(received: 0, total: 100)

    var body: some View {
		VStack {
			CircularProgressBar(circleProgress: circleProgress,
								size: 80,
								showPercentage: true)

			CircularProgressBar(circleProgress: circleProgress,
								size: 60,
								showPercentage: true)

			CircularProgressBar(circleProgress: circleProgress,
								size: 40,
								showPercentage: true)

			CircularProgressBar(circleProgress: circleProgress,
								size: 20,
								showPercentage: true)

			CircularProgressBar(circleProgress: circleProgress,
								size: 100,
								showPercentage: true)

			Button(action: {
				startLoading()
			}, label: {
				Text("Start Loading")
			})

			Button(action: {
				reset()
			}, label: {
				Text("Reset")
			})

		}
    }


	private func startLoading() {
		_ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
			withAnimation {
				if case .determinate(let rec, let total) = circleProgress {
					let newValue = rec + 1
					circleProgress = .determinate(received: newValue, total: total)
				}
				if circleProgress.relative >= 1.0 {
					timer.invalidate()
//					reset()
				}
			}
		})
	}

	private func reset() {
		circleProgress = .determinate(received: 0, total: 100)
	}
}

struct ProgressBarDemo_Previews: PreviewProvider {
    static var previews: some View {
		ProgressBarDemo()
    }
}
