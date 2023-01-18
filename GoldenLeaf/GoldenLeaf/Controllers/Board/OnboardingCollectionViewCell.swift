//
//  OnboardingCollectionViewCell.swift
//  GoldenLeaf
//
//  Created by elham on 1/18/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideDes: UILabel!
    
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitle.text = slide.title
        slideDes.text = slide.description
    }
}
