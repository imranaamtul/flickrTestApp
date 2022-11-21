//
//  File.swift
//  flickrTestAPP
//
//  Created by amtul imrana on 20/11/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var imageText: UIImage
    var descriptionText: String
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = imageText
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var descriptionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont (ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = descriptionText
        label.textAlignment = .center
        return label
    }()
    
    func configureViews() {
        view.addSubview (imageView)
        view.addSubview (descriptionsLabel)
        
        NSLayoutConstraint.activate([
            
            imageView.leftAnchor.constraint (equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor .constraint (equalTo: view.rightAnchor, constant: -20),
            imageView.topAnchor.constraint (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            imageView.heightAnchor.constraint (equalToConstant: view.frame .height/2),
            
            descriptionsLabel.leftAnchor.constraint (equalTo: view.leftAnchor, constant: 20),
            descriptionsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            descriptionsLabel.topAnchor.constraint (equalTo: imageView.bottomAnchor, constant: 10),
        ])
        
    }
    init(imageText: UIImage, descriptionText: String ) {
        self.imageText = imageText
        self.descriptionText = descriptionText
        super.init (nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError ("This class does not support NSCoder")
    }
    override func viewDidLoad() {
        super.viewDidLoad ()
        configureViews ()
        view?.backgroundColor = .white
    }
}
