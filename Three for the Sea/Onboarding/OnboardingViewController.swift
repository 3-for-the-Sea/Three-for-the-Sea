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
    
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var advanceButton: UIButton!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        updateButtonTitle()
    }
    
    
    // MARK: - Collection View methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.configureCell(page: onboardingPages[indexPath.item])
        
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
        
        guard let pageControl = sender as? UIPageControl else { return }
        
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func advanceButtonTapped(_ sender: Any) {
        
        let nextPage = pageControl.currentPage + 1
        
        guard nextPage < onboardingPages.count else {
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
    
    fileprivate func setupUI() {
        advanceButton.layer.cornerRadius = 18
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        
        pageControl.numberOfPages = onboardingPages.count
    }
    
    private func updateButtonTitle() {
        let title = onboardingPages[pageControl.currentPage].buttonText
        
        self.advanceButton.setTitle(title, for: .normal)
    }
}

