//
//  ViewController.swift
//  AutoImageSlider
//
//  Created by Nazim Uddin on 27/8/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slidercollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    var imageArray:[UIImage] = [UIImage]()
    var doubalTapGesture:UITapGestureRecognizer!
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        pageView.numberOfPages = imageArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
           // self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.didChangeImage), userInfo: nil, repeats: true)
        }
        self.setDoubalClick()
    }
    func getImage(){
        imageArray.append(UIImage(named: "b1.jpg")!)
        imageArray.append(UIImage(named: "b7.jpg")!)
        imageArray.append(UIImage(named: "b8.jpg")!)
        imageArray.append(UIImage(named: "m5.jpg")!)
        imageArray.append(UIImage(named: "m6.jpg")!)
        imageArray.append(UIImage(named: "m7.jpg")!)
        imageArray.append(UIImage(named: "m10.jpg")!)
    }
    @objc func didChangeImage(){
        if counter < imageArray.count {
            let indexPath = IndexPath(item: counter, section: 0)
            self.slidercollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        }else{
            counter = 0
            let indexPath = IndexPath(item: counter, section: 0)
            self.slidercollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
    func setDoubalClick(){
        doubalTapGesture  = UITapGestureRecognizer(target: self, action: #selector(didImageView))
        doubalTapGesture.numberOfTapsRequired = 2
        self.slidercollectionView.addGestureRecognizer(doubalTapGesture)
        
        doubalTapGesture.delaysTouchesBegan = true
    }
    @objc func didImageView(){
        let pointCollectionViewCell = doubalTapGesture.location(in: slidercollectionView)
        if let seletedIndexPath = slidercollectionView.indexPathForItem(at: pointCollectionViewCell) {
            let imageInfo = GSImageInfo(image: imageArray[seletedIndexPath.row], imageMode: .aspectFit)
            let transitionInfo = GSTransitionInfo(fromView: slidercollectionView)
            let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
            imageViewer.dismissCompletion = {
                print("Dismiss")
        
            }
            present(imageViewer, animated: true)
        }
    }

}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let img = cell.viewWithTag(10) as! UIImageView
        img.image = imageArray[indexPath.row]
        
        pageView.currentPage = indexPath.row
        return cell
    }
    
}
extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = slidercollectionView.frame.size
        return CGSize(width: size.width , height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

