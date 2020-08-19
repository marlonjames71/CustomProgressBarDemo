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

struct CircularProgressBar: View {

	let circleProgress: AsyncImageProgress

	let size: CGFloat
	private var lineWidth: CGFloat { size * 0.0666666666 }

	let showPercentage: Bool



	var body: some View {
		ZStack {
			Circle()
				.stroke(Color.gray, lineWidth: lineWidth)
				.frame(width: size, height: size, alignment: .center)

			switch circleProgress {
			case .determinate:
				Circle()
					.trim(from: 0.0, to: CGFloat(circleProgress.relative))
					.stroke(Color.pink, style: StrokeStyle(lineWidth: (lineWidth * 1.5), lineCap: .round, lineJoin: .round))
					.frame(width: size, height: size, alignment: .center)
					.rotationEffect(Angle(degrees: -90))
			case .indeterminate:
				Circle()
					.trim(from: 0.0, to: 0.2)
					.stroke(Color.pink, style: StrokeStyle(lineWidth: (lineWidth * 1.5), lineCap: .round, lineJoin: .round))
					.frame(width: size, height: size, alignment: .center)
					.rotationEffect(Angle(degrees: -90))
			}

			if showPercentage {
				Text("\(Int(circleProgress.relative * 100))%")
					.font(.system(size: size * 0.3, weight: .regular, design: .monospaced))
					.padding()
			}
		}
	}
}
