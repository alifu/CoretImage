//
//  ViewController.swift
//  CoretImage
//
//  Created by alifu on 10/04/2024.
//  Copyright (c) 2024 alifu. All rights reserved.
//

import CoretImage
import UIKit

class CoretViewController: UIViewController {
     
    var coretView = CoretView()
    var removeButton = UIButton()
    var previewButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let screen = UIScreen.main.bounds
        coretView = CoretView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height / 2))
        removeButton = UIButton(frame: CGRect(x: 0, y: (screen.height / 2) + 8, width: screen.width, height: 40))
        previewButton = UIButton(frame: CGRect(x: 0, y: (screen.height / 2) + 54, width: screen.width, height: 40))
        self.view.addSubview(coretView)
        self.view.addSubview(removeButton)
        self.view.addSubview(previewButton)
        self.coretView.applyImage(with: UIImage(named: "leaves"))
        
        self.removeButton.setTitle("Remove", for: .normal)
        self.removeButton.setTitleColor(.black, for: .normal)
        self.removeButton.addTarget(self, action: #selector(removeCoret), for: .touchUpInside)
        
        self.previewButton.setTitle("Preview", for: .normal)
        self.previewButton.setTitleColor(.black, for: .normal)
        self.previewButton.addTarget(self, action: #selector(openPreview), for: .touchUpInside)
        
        self.coretView.applyLineWidth(with: 5.0)
        self.coretView.applyStrokeColor(with: UIColor.yellow.cgColor)
    }
    
    @objc func removeCoret() {
        coretView.undoLastStroke()
    }
    
    @objc func openPreview() {
        let resultImage = coretView.getResultImage()
        let previewViewController = PreviewViewController()
        previewViewController.previewImage = resultImage
        self.present(previewViewController, animated: true)
    }
}

