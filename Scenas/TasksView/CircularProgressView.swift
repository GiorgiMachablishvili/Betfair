

import UIKit

class CircularProgressView: UIView {

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    var trackColor: UIColor = UIColor(hexString: "FFFFFF") {
        didSet { trackLayer.strokeColor = trackColor.cgColor }
    }
    var progressColor: UIColor = UIColor.mainViewsBackgroundYellow {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        let circularPath = UIBezierPath(ovalIn: bounds.insetBy(dx: 10 * Constraint.xCoeff, dy: 10 * Constraint.yCoeff))

        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10 * Constraint.xCoeff
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10 * Constraint.xCoeff
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setupLayers()
//    }
//
//    func setProgress(to progress: CGFloat) {
//        progressLayer.strokeEnd = progress
//    }

    override func layoutSubviews() {
            super.layoutSubviews()
            layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            setupLayers()
        }

        func setProgress(to progress: CGFloat, animated: Bool = true) {
            CATransaction.begin()
            CATransaction.setAnimationDuration(animated ? 0.3 : 0.0) // Smooth transition
            progressLayer.strokeEnd = progress
            CATransaction.commit()
        }
}

