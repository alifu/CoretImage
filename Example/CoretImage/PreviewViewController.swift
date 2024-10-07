//
//  PreviewViewController.swift
//  CoretImage_Example
//
//  Created by Alif Phincon on 06/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    var previewImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        imageView.image = previewImage
        imageView.contentMode = .scaleAspectFill

        // Add constraints to the subview relative to its superview
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}
