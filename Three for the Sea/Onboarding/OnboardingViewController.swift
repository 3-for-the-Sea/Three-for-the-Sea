//
//  OnboardingViewController.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/3/21.
//

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func didFinish()
}

class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    weak var delegate: OnboardingCoordinatorDelegate?
    
    let pages: [OnboardingPage] =
        [OnboardingPage(imageName: "onboarding0",
                        title: "Ocean Blue Mission",
                        description: "Join us for a mission that's as vast, critical, and inspiring as the Ocean itself.",
                        buttonText: "Join Us!"),
        OnboardingPage(imageName: "onboarding1",
                       title: "One World Ocean",
                       description: "Every stream, river, and ocean is part of a single global ecosystem: One World Ocean.",
                       buttonText: "Get Ready!"),
        OnboardingPage(imageName: "onboarding2",
                       title: "Pick up 3 for the Sea",
                       description: "Pick up at least 3 pieces of plastic daily at your neighborhood park, river, beach, or sidewalk and keep track of your impact!",
                       buttonText: "Get Set!"),
        OnboardingPage(imageName: "onboarding3",
                       title: "Save the Ocean Together",
                       description: "Request a cleanup and Ocean Blue Project can help you organize a cleanup at your local beach or river!",
                       buttonText: "Go!")]
    
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var advanceButton: UIButton!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        advanceButton.layer.cornerRadius = 18
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        
        pageControl.numberOfPages = pages.count
        
        updateButtonTitle()
    }
    
    
    // MARK: - Collection View methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.configureCell(page: pages[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        updateButtonTitle()
    }
    
    
    // MARK: - Actions
    
    @IBAction func pageControlChanged(_ sender: Any) {
        
        guard let pc = sender as? UIPageControl else { return }
        
        collectionView.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func advanceButtonTapped(_ sender: Any) {
        
        let nextPage = pageControl.currentPage + 1
        
        guard nextPage < pages.count else {
            delegate?.didFinish()
            return
        }
        
        collectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0),
                                    at: .centeredHorizontally,
                                    animated: true)
        
        pageControl.currentPage = nextPage
        updateButtonTitle()
    }
    
    
    // MARK: - Helpers
    
    private func updateButtonTitle() {
        let title = pages[pageControl.currentPage].buttonText
        
        self.advanceButton.setTitle(title, for: .normal)
    }
}

