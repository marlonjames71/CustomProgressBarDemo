//
//  CircleProgressBar.swift
//  CustomProgressBarDemo
//
//  Created by Marlon Raskin on 8/19/20.
//

import SwiftUI

enum AsyncImageProgress {
	case indeterminate
	case determinate(received: Int64, total: Int64)

	var relative: Double {
		let value: Double
		switch self {
		case .indeterminate:
			value = -1
		case .determinate(received: let rec, total: let total):
			value = Double(rec) / Double(total)
		}
		return value
	}
}

struct CircularProgressIndicator: View {

	let progress: AsyncImageProgress

	let size: CGFloat
	private var lineWidth: CGFloat { size * 0.0666666666 }
	@State private var indeterminateRotationDegrees: Double = 0

	private let indeterminateText: String
	private let showPercentage: Bool

	private let staticRingColor: Color
	private let progressColor: Color
	private let textColor: Color

	static private let percentageFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .percent
		return formatter
	}()


	/// Initializes a new progress indicator with custom parameters
	init(progress: AsyncImageProgress,
		 size: CGFloat,
		 indeterminateText: String = "",
		 showPercentage: Bool = false,
		 staticRingColor: Color = Color(.systemGray5),
		 progressColor: Color = .pink,
		 textColor: Color = .primary) {
		self.progress = progress
		self.size = size
		self.indeterminateText = indeterminateText
		self.showPercentage = showPercentage
		self.staticRingColor = staticRingColor
		self.progressColor = progressColor
		self.textColor = textColor
	}

	/// Convenience init for indeterminate progress indicator
	init(size: CGFloat,
		 indeterminateText: String = "",
		 staticRingColor: Color = Color(.systemGray5),
		 progressColor: Color) {
		self.init(progress: .indeterminate, size: size, indeterminateText: indeterminateText, staticRingColor: staticRingColor, progressColor: progressColor)
	}

	var body: some View {
		ZStack {
			Circle()
				.stroke(staticRingColor, lineWidth: lineWidth)
				.frame(width: size, height: size, alignment: .center)

			switch progress {
			case .determinate:
				Circle()
					.trim(from: 0.0, to: CGFloat(progress.relative))
					.stroke(progressColor, style: StrokeStyle(lineWidth: (lineWidth * 1.5), lineCap: .round, lineJoin: .round))
					.frame(width: size, height: size, alignment: .center)
					.rotationEffect(Angle(degrees: -90))
			case .indeterminate:
				Circle()
					.trim(from: 0.0, to: 0.6)
					.stroke(
						LinearGradient(
							gradient: Gradient(colors: [progressColor, progressColor.opacity(0.0)]),
							startPoint: .leading,
							endPoint: .trailing
						), style:
							StrokeStyle(
								lineWidth: (lineWidth * 1.3),
								lineCap: .round,
								lineJoin: .round
							)
					)
					.frame(width: size, height: size, alignment: .center)
					.rotationEffect(Angle(degrees: indeterminateRotationDegrees))
					.animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
			}

			if showPercentage {
				switch progress {
				case .determinate:
					Text(Self.percentageFormatter.string(from: progress.relative as NSNumber) ?? "0%")
						.foregroundColor(textColor)
						.font(.system(size: size * 0.3, weight: .regular, design: .monospaced))
						.padding()
				case .indeterminate:
					Text("\(indeterminateText)")
						.foregroundColor(textColor)
						.font(.system(size: size * 0.3, weight: .regular, design: .monospaced))
						.padding()
				}
			}
		}
		.onAppear {
			indeterminateRotationDegrees += 360
		}
	}
}
