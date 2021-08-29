//
//  RoundUIImage.swift
//  VK Feed
//
//  Created by Артём on 13.08.2021.
//

import UIKit

class UIRoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
    }
}
