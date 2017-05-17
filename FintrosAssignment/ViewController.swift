//
//  ViewController.swift
//  FintrosAssignment
//
//  Created by Minhung Ling on 2017-05-15.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var tableViewTopAnchor: NSLayoutConstraint!
    let objectManager = ObjectManager.sharedInstance
    var headerArray = [UITableViewHeaderFooterView]()
    
    var rowHeight:CGFloat = 40
    var selectedSection = 0
    var collectionViewDataSourceArray = [CollectionViewDataSource]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        objectManager.setUp()
    }
    
    override func viewDidLayoutSubviews() {
        rowHeight = view.frame.width*0.85
    }
    
    @IBAction func tableViewTapped(_ sender: UITapGestureRecognizer) {
        let tappedPoint = sender.location(in: tableView)
        for index in 0..<objectManager.sectionNames.count {
            guard let header = tableView.headerView(forSection: index) else {
                return
            }
            if header.frame.contains(tappedPoint) {
                tableView.beginUpdates()
                selectedSection = index
                moveTableView()
                tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        if section == 0 {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        header.textLabel?.frame = header.frame
        header.backgroundView?.backgroundColor = .clear
        headerArray.append(header)
    }
    
    func moveTableView() {
        for index in 0..<self.headerArray.count {
            let header = self.headerArray[index]
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            if index == self.selectedSection {
                header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                header.textLabel?.sizeToFit()
            }
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewTopAnchor.constant = CGFloat(56 - self.selectedSection * 28)
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func panOnView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        tableView.beginUpdates()
        if translation.y > 50 {
            selectedSection += 1
            sender.setTranslation(CGPoint(x: 0, y: 0), in: view)
        }
        
        if translation.y < -50 {
            selectedSection -= 1
            sender.setTranslation(CGPoint(x: 0, y: 0), in: view)
        }
        
        if selectedSection < 0 {
            selectedSection = 0
        }
        
        if selectedSection > objectManager.sectionNames.count - 1 {
            selectedSection = objectManager.sectionNames.count - 1
        }
        moveTableView()
        tableView.endUpdates()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemWidth = Float(rowHeight)
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.pointee.x)
        var newTargetOffset: Float = 0
        
        newTargetOffset = floorf(currentOffset / itemWidth) * itemWidth
        
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / itemWidth) * itemWidth
        }
        
        if newTargetOffset < 0 {
            newTargetOffset = 0
        }
        
        //        else if (newTargetOffset > Float(scrollView.contentSize.width)){
        //            newTargetOffset = Float(Float(scrollView.contentSize.width))
        //        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectManager.sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == selectedSection {
            return rowHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let name = "- \(objectManager.sectionNames[section])"
        return name.uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        let dataSource = CollectionViewDataSource()
        collectionViewDataSourceArray.append(dataSource)
        dataSource.sectionIndex = indexPath.section
        cell.collectionView.dataSource = dataSource
        cell.collectionView.delegate = self
        let layout = cell.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let side = rowHeight
        let size = CGSize(width: side, height: side)
        layout.itemSize = size
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionat section: Int) -> CGFloat {
        return rowHeight
    }
    
}
