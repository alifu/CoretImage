import UIKit

class CoretView: UIView {
    private var path = UIBezierPath()
    private var shapeLayers = [CAShapeLayer]() // Store all layers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .gray
    }

    // Start a new stroke
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        path = UIBezierPath() // New path for each stroke
        path.lineWidth = 2.0
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = path.lineWidth
        self.layer.addSublayer(shapeLayer)
        
        shapeLayers.append(shapeLayer) // Store the new shape layer
        
        if let touch = touches.first {
            path.move(to: touch.location(in: self))
        }
    }

    // Continue drawing the stroke
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            path.addLine(to: touch.location(in: self))
            shapeLayers.last?.path = path.cgPath // Update the current layer
        }
    }

    // Remove the last stroke
    func undoLastStroke() {
        guard !shapeLayers.isEmpty else { return }
        let lastLayer = shapeLayers.removeLast()
        lastLayer.removeFromSuperlayer() // Remove the last layer from the view
    }
}