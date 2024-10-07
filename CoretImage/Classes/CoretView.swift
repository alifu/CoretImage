import UIKit

public class CoretView: UIView {
    
    private var imageView = UIImageView()
    private var canvas = UIView()
    private var path = UIBezierPath()
    private var shapeLayers = [CAShapeLayer]() // Store all layers
    private var image: UIImage?
    private var lineWidth: CGFloat = 2.0
    private var strokeColor: CGColor? = UIColor.red.cgColor
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    // Setup view
    private func setupView() {
        self.backgroundColor = .gray
        self.clipsToBounds = true
        
        // Add `imageView` to the subview
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit

        // Add constraints to the subview relative to its superview
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        // Add `canvas` view to the subview
        canvas.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(canvas)
        
        // Add constraints to the subview relative to its superview
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            canvas.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            canvas.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            canvas.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    // Start a new stroke
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        path = UIBezierPath() // New path for each stroke
        path.lineWidth = self.lineWidth
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = self.strokeColor
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = path.lineWidth
        self.canvas.layer.addSublayer(shapeLayer)
        
        shapeLayers.append(shapeLayer) // Store the new shape layer
        
        if let touch = touches.first {
            path.move(to: touch.location(in: self))
        }
    }

    // Continue drawing the stroke
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            path.addLine(to: touch.location(in: self))
            shapeLayers.last?.path = path.cgPath // Update the current layer
        }
    }
    
    // Apply image as background
    public func applyImage(with image: UIImage?) {
        self.imageView.image = image
        self.image = image
    }
    
    // Apply line width of shape
    public func applyLineWidth(with lineWidth: CGFloat) {
        self.lineWidth = lineWidth
    }
    
    // Apply CGColor of shape
    public func applyStrokeColor(with strokeColor: CGColor?) {
        self.strokeColor = strokeColor
    }

    // Remove the last stroke
    public func undoLastStroke() {
        guard !shapeLayers.isEmpty else { return }
        let lastLayer = shapeLayers.removeLast()
        lastLayer.removeFromSuperlayer() // Remove the last layer from the view
    }
    
    // Get Image Result
    public func getResultImage() -> UIImage? {
        return self.combineImageAndAnnotations()
    }
    
    // Combine Image and Annotations. If image is nil then return nil
    private func combineImageAndAnnotations() -> UIImage? {
        if let `image` = image {

            let imageSize = image.size
            let drawingViewSize = canvas.bounds.size
            
            // Calculate aspect fit size of the image within the DrawingView
            let aspectWidth = drawingViewSize.width / imageSize.width
            let aspectHeight = drawingViewSize.height / imageSize.height
            let aspectFitScale = min(aspectWidth, aspectHeight)
            
            // Calculate the size of the image as displayed in the drawing view
            let scaledImageSize = CGSize(width: imageSize.width * aspectFitScale,
                                         height: imageSize.height * aspectFitScale)
            
            // Calculate the x and y offsets to center the image in the view
            let offsetX = (drawingViewSize.width - scaledImageSize.width) / 2
            let offsetY = (drawingViewSize.height - scaledImageSize.height) / 2
            
            // Create a renderer with the size of the original image
            let renderer = UIGraphicsImageRenderer(size: imageSize)
            let combinedImage = renderer.image { context in
                // Draw the original image at (0, 0)
                image.draw(at: CGPoint.zero)
                
                // Save the current graphics state
                context.cgContext.saveGState()
                
                // Scale and translate the context to match the aspect fit image
                context.cgContext.translateBy(x: -offsetX / aspectFitScale, y: -offsetY / aspectFitScale)
                context.cgContext.scaleBy(x: 1 / aspectFitScale, y: 1 / aspectFitScale)
                
                // Render the drawingView's layer (scaled and aligned properly)
                canvas.layer.render(in: context.cgContext)
                
                // Restore the graphics state
                context.cgContext.restoreGState()
            }
            
            return combinedImage
        }
        return nil
    }
}
