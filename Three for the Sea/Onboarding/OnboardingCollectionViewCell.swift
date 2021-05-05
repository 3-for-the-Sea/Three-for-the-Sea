//
//  OnboardingCollectionViewCell.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/3/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(page: OnboardingPage) {
        titleLabel.text = page.title
        descriptionTextView.text = page.description
        
        guard let image = UIImage(named: page.imageName) else { return }
        
        imageView.image = image
    }

}
