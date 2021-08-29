//
//  ArtistTableViewCell.swift
//  Musicians
//
//  Created by Артём on 29.08.2021.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    private let profileImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    var imageURL: URL? {
        didSet {
            profileImageView.load(from: imageURL)
        }
    }
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    var nameText: String? {
        get {
            nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        profileImageView.fillSuperview(padding: UIEdgePaddings(top: 8,
                                                               trailing: nil,
                                                               bottom: 8,
                                                               leading: 16))
        
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        nameLabel.fillSuperview(padding: UIEdgePaddings(top: 8,
                                                        trailing: 8,
                                                        bottom: 8,
                                                        leading: nil))
        
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                           constant: 16).isActive = true
    }
    
    override func prepareForReuse() {
        imageURL = nil
    }
}
