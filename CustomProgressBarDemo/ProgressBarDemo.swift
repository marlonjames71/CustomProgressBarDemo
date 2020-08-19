//
//  ContentView.swift
//  CustomProgressBarDemo
//
//  Created by Marlon Raskin on 8/19/20.
//

import SwiftUI

struct ProgressBarDemo: View {

	@State private var circleProgress: AsyncImageProgress = .determinate(received: 0, total: 100)
	@State private var indeterminateProgress: AsyncImageProgress = .indeterminate

	@State private var color: Color = .pink

    var body: some View {
		VStack(spacing: 12) {

			CircularProgressIndicator(size: 50, progressColor: .pink)

			CircularProgressIndicator(progress: circleProgress,
									  size: 80,
									  showPercentage: true,
									  progressColor: color,
									  textColor: .primary)

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
					color = .green
					timer.invalidate()
				}
			}
		})
	}

	private func reset() {
		circleProgress = .determinate(received: 0, total: 100)
		color = .pink
	}
}

struct ProgressBarDemo_Previews: PreviewProvider {
    static var previews: some View {
		ProgressBarDemo()
    }
}
