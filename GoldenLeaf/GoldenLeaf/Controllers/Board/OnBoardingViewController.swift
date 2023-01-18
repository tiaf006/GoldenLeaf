//
//  OnBoardingViewController.swift
//  GoldenLeaf
//
//  Created by elham on 1/18/23.
//

import UIKit

class OnBoardingViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButt: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
   
    //Change butt
    var currentPage = 0  {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButt.setTitle("Start Now", for: .normal)
            } else {
                nextButt.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     slides = [
        OnboardingSlide(title: "We sell the finest plants", description: ".", image: #imageLiteral(resourceName: "mitchel-lensink-Y2OCQVuz6XM-unsplash")),
        OnboardingSlide(title: "Delivery to your doorstep", description: ".", image: #imageLiteral(resourceName: "Unknown")),
        OnboardingSlide(title: "", description: ".", image: #imageLiteral(resourceName: "kara-eads-xRyL63AwZFE-unsplash"))
    ]
    
    pageControl.numberOfPages = slides.count
    
    }
    

    @IBAction func nextButClicked(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
    
            let controller = storyboard?.instantiateViewController(identifier: "HomeN") as! UINavigationController
            
            present(controller, animated: true, completion: nil)
            
        }else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

}


extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let width = scrollView.frame.width
           currentPage = Int(scrollView.contentOffset.x / width)
           
       }
}

