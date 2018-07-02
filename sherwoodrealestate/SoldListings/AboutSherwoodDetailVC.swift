//
//  AboutSherwoodDetailVC.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 6/25/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Parse
import MapKit
//let PROP_CLASS_NAME = "AboutSherwoodVC"

class AboutSherwoodDetailVC: UICollectionViewController, MKMapViewDelegate  {
    let cellId = "cellId"
    var propObj = PFObject(className: PROP_CLASS_NAME)
    var listingClass = PFObject(className: PROP_CLASS_NAME)
    
    let descriptionId = "descriptionId"
    let headerId = "headerId"
    let titleId = "titleId"
    let mainId = "mainId"


    var listing = PFObject(className: PROP_CLASS_NAME) {
        didSet {
            var listingClass = PFObject(className: PROP_CLASS_NAME)

//            if let listingName = listingClass["title"] as? String {
//                self.nameLabel.text = listingName
//                print("I am \(listingName)")
//            }

//            print(listing)
//            print(listing["title"])
//            print(listing["description"])
            
//            if listing?.StandardFields.Photos != nil {
//                return
//            }
//            if listing?.StandardFields.VirtualTours != nil {
//                return
//            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Im in View Will Appear")
        super.viewWillAppear(animated)
        self.title = listingClass["title"] as? String
        
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(ATitleCell.self, forCellWithReuseIdentifier: "titleId")
        collectionView?.register(AnAppDetailDescriptionCell.self, forCellWithReuseIdentifier: "descriptionId")
        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: "mainId")
        collectionView?.backgroundColor = UIColor.yellow
//        setupViews()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
  
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//
//        return cell
//    }
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: range)
        
        if let listingPrice = listingClass["description"] as? String {
            attributedText.append(NSAttributedString(string: listingPrice, attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Light", size: 16)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        }
        
        
//        if let desc = listing?.StandardFields.PublicRemarks {
//            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Light", size: 16)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
//        }
        
        return attributedText
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! ATitleCell
//            var listingClass = PFObject(className: PROP_CLASS_NAME)
//            listingClass = listingClass[indexPath.row]
        
            if let listingName = listingClass["title"]  {
                cell.nameLabel.text = listingName as? String
                
                print("I am \(listingName)")
            }

            return cell
    }
}
class ATitleCell: BaseCell {
//    var propObj = PFObject(className: PROP_CLASS_NAME)
//    {
//        didSet {
//            print(propObj)
//            //var propObj = PFObject(className: PROP_CLASS_NAME)
//            if let listingName = propObj["title"] as? String {
//                self.nameLabel.text = listingName
//
//                print("I am \(listingName)")
//            }
//
//
//        }
//    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont(name: "Avenir Heavy", size: 17)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Avenir Light", size: 16)
        
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    override func setupViews() {
        
        
        addSubview(nameLabel)
        addSubview(textView)


        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: nameLabel)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)

        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(20)]|", views: nameLabel, textView)

        
    }
}

class AnAppDetailDescriptionCell: BaseCell {
    var recentListings: PFObject? {
        didSet {
        }
    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "Avenir Light", size: 16)
        
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
    }
}


class MainCell: BaseCell {
    var recentListings: PFObject? {
        didSet {
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    
    let image: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named:"pic")
        //        iv.backgroundColor = UIColor.black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    
    
    func setupThumbNailImage() {
        
//
//        if let thumbnailImageUrl = listing?.StandardFields.Photos[0].Uri1024 {
//            imageView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
//        }
        
    }
    override func setupViews() {
        //        backgroundColor = UIColor.clear
        
        addSubview(image)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: image)
        addConstraintsWithFormat(format: "V:|[v0]|", views: image)
        
        
    }
}











