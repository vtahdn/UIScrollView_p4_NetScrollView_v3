//
//  ScrollView.swift
//  UIScrollView_p4_NetScrollView_v3
//
//  Created by macbook pro  on 9/1/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var first = false
    var currentPage = 0
    var images: [String] = []
    
    var scrollViews: [UIScrollView] = []
    var photos: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial data.
        initData()
        
    }
    
    // Initial data.
    func initData() {
        
        // Initial LinhKa photos.
        images = ["Linh_Ka_01", "Linh_Ka_02", "Linh_Ka_03"]
        
        // Set a current page.
        pageController.currentPage = currentPage
        
        // Set number of page.
        pageController.numberOfPages = images.count
        
        // Set the background color of scroll-views.
        scrollView.backgroundColor = UIColor.blackColor()
        
    }
    
    // Initial data at the first time.
    override func viewDidLayoutSubviews() {
        
        // Check: initial if it is the first time.
        if (!first) {
            
            first = true
            
            let scrollSize = scrollView.frame.size
            
            // Make the loop rung faster.
            let imageCount = images.count
            
            // The content of the scroll-views is equal the size of photos.
            scrollView.contentSize = CGSizeMake(scrollSize.width * CGFloat(images.count), 0)
            
            // Move the screen (the scroll view) to a current position.
            scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollSize.width, 0)
            
            // Initial all Linh Ka photos by a "for" loop from images array.
            for (var i = 0; i < imageCount; i++) {
                
                //Initial a image
                let imgView = UIImageView(image: UIImage(named: images[i] + ".jpg"))
                imgView.frame = CGRectMake(0, 0, scrollSize.width, scrollSize.height)
                imgView.contentMode = .ScaleAspectFit
                
                // Enable touch-functions to zoom
                imgView.userInteractionEnabled = true
                imgView.multipleTouchEnabled = true
                
                // Set zoom in by a single tap
                let tap = UITapGestureRecognizer(target: self, action: Selector("zoomIn:"))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                
                // Set zoom out by a double tap
                let doubleTap = UITapGestureRecognizer(target: self, action: Selector("zoomOut:"))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.requireGestureRecognizerToFail(doubleTap)
                
                // Addimages to the "photos" array
                photos.append(imgView)
                
                // Initial a sub scroll-view for each photo.
                let subScrollView = UIScrollView(frame: CGRectMake( CGFloat(i) * scrollSize.width, 0, scrollSize.width, scrollSize.height))
                
                // Set zoom-scale for the sub scroll-view
                subScrollView.minimumZoomScale = 1
                subScrollView.maximumZoomScale = 2
                subScrollView.delegate = self
                subScrollView.contentSize = imgView.bounds.size
                
                // Add a image to the sub scroll-view
                subScrollView.addSubview(imgView)
                
                // Add a sub scroll-view  to the "scrollViews" array.
                scrollViews.append(subScrollView)
                
                // Add this sub scroll-view to the main one.
                self.scrollView.addSubview(subScrollView)
                
            }
            
        }
    }
    
    // Zoom function
    func zoom(scale: CGFloat, center: CGPoint) {
        
        var rectangle = CGRect()
        let scrollSize = scrollView.bounds.size
        
        // Set a zooming-rectangle
        rectangle.size.height = scrollSize.height / scale
        rectangle.size.width = scrollSize.width / scale
        
        // Locate a zooming-position
        rectangle.origin.x = center.x - (rectangle.size.width / 2)
        rectangle.origin.y = center.y - (rectangle.size.height / 2)
        
        // Zoom a current photo in it's scroll-view by the retangle
        scrollViews[pageController.currentPage].zoomToRect(rectangle, animated: true)
        
    }
    
    // Zoom-in function
    func zoomIn(gesture: UITapGestureRecognizer) {
        
        // Locate a position of a photo by a current page.
        let position = gesture.locationInView(photos[pageController.currentPage])
        
        // Zoom by a scale of a photo in it's scroll-view by a current page.
        zoom(scrollViews[pageController.currentPage].zoomScale * 1.5, center: position)
        
    }
    
    // Zoom-out function
    func zoomOut(gesture: UITapGestureRecognizer) {
        
        // Locate a position of a photo by a current page.
        let position = gesture.locationInView(photos[pageController.currentPage])
        
        // Zoom by a scale of a photo in it's scroll-view by a current page.
        zoom(scrollViews[pageController.currentPage].zoomScale * 0.5, center: position)
        
    }
    
    // Activate zooming a photo by a current page.
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return photos[pageController.currentPage]
        
    }
    
    // Move the screen to a new page in the page controller.
    @IBAction func pageControllerAction(sender: UIPageControl) {
        
        // Move the screen (the scroll view) to a current page.
        scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)
        
    }

    // Function: move to left.
    @IBAction func leftAction(sender: UIButton) {
        
        // Get the current page
        var index = CGFloat(pageController.currentPage)
        
        // If the current page is not the first one, move the screen to left by 1 page.
        if (index > 0) {
            index -= 1
            scrollView.contentOffset = CGPointMake(index * scrollView.frame.size.width, 0)
            pageController.currentPage = Int(index)
        }
        
    }
    
    
    @IBAction func rightAction(sender: UIButton) {
        
        // Get the current page
        var index = CGFloat(pageController.currentPage)
        
        // If the current page is not the last one, move the screen to right by 1 page.
        if (index < CGFloat(images.count - 1)) {
            index += 1
            scrollView.contentOffset = CGPointMake(index * scrollView.frame.size.width, 0)
            pageController.currentPage = Int(index)
        }
    }
    
    // Function: locate a page number after scrolling
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        
        pageController.currentPage = Int(page)
        
    }
    
    
    
    
    
    
    
    
    
}
