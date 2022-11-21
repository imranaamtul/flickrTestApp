//
//  MainVCCustomCell.swift
//  flickrTestAPP
//
//  Created by amtul imrana on 20/11/22.
//

import Foundation
import UIKit

class MainVCCustomCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    lazy var cellimage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    lazy var cellTitleLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont (ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    func configureViews () {
        contentView.addSubview(cellimage)
        contentView.addSubview(cellTitleLabel)
        
        
        NSLayoutConstraint.activate([
            
            cellimage.leftAnchor.constraint (equalTo: contentView.leftAnchor),
            cellimage.centerYAnchor.constraint (equalTo: contentView.centerYAnchor),
            cellimage.heightAnchor.constraint (equalToConstant: 100),
            cellimage.widthAnchor.constraint (equalToConstant: 100),
            
            cellTitleLabel.leftAnchor.constraint (equalTo: cellimage.rightAnchor, constant: 15),
            cellTitleLabel.centerYAnchor.constraint(equalTo:contentView.centerYAnchor),
            cellTitleLabel.heightAnchor.constraint(equalToConstant:100)
        ])
    }
    
    func configureCellData(image: UIImage, label: String) {
        cellimage.image = image
        cellTitleLabel.text = label
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init (style: style, reuseIdentifier: reuseIdentifier)
        configureViews ()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
