//
//  OnBoardingViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit

class OnBoardingViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButt: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
     //var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

     slides = [
        OnboardingSlide(title: "We sell the finest plants", description: "🪴.", image: #imageLiteral(resourceName: "mitchel-lensink-Y2OCQVuz6XM-unsplash")),
        OnboardingSlide(title: "Delivery to your doorstep", description: "📦🍃.", image: #imageLiteral(resourceName: "Unknown")),
        OnboardingSlide(title: "Start browsing plants now", description: "🌿.", image: #imageLiteral(resourceName: "kara-eads-xRyL63AwZFE-unsplash"))
    ]
    
    pageControl.numberOfPages = slides.count
    
    }
    

    @IBAction func nextButClicked(_ sender: UIButton) {
    }

}


extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup (slides [indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
//       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//           let width = scrollView.frame.width
//           currentPage = Int(scrollView.contentOffset.x / width)
//       }
}

