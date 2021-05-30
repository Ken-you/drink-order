//
//  MenuViewController.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //  不同飲料分類在不同的 containerView
    @IBOutlet var containerViews: [UIView]!
    
    @IBOutlet weak var drinkSegments: UISegmentedControl!
    
    
    struct PropertyKeys {
            static let menuCell = "menuCell"
        }

    
    // 上方廣告
    // 抓 Assets 裡的素材，加入 cell 裡面的 imageArray[]
    let imageArray :[UIImage] =
        
        {
            var arr = [UIImage]()
            
            for i in 1...11 {
                let image = UIImage(named: String(i))
                arr.append(image!)
            }
            
        arr.append(UIImage(named: "1")!)
        return arr
    }()

    var imageIndex = 0

    var collectionView :UICollectionView!
    
    let width = UIScreen.main.bounds.width
    
    
    // 加入 CollectionView 並設定條件
    func setupCollectionView() {

        let layout :UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal

        layout.sectionInset = UIEdgeInsets.zero

        layout.itemSize = CGSize(width: width, height: 200)

        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(0))

        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal

        let rect = CGRect(x: 0, y: 20, width: width, height: width * (9/16))

        self.collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AdCollectionViewCell.self, forCellWithReuseIdentifier: PropertyKeys.menuCell)

        self.collectionView.isPagingEnabled = true
        self.collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
    }


    
    // 實作 UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyKeys.menuCell, for: indexPath) as! AdCollectionViewCell

        cell.imageView.image = imageArray[indexPath.item]

        return cell
    }
    
    
    //  廣告輪播
    @objc func changeBanner() {
            
            imageIndex += 1
            let indexPath: IndexPath = IndexPath(item: imageIndex, section: 0)
        
            if imageIndex < (imageArray.count - 1) {
                
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
            }else if imageIndex == imageArray.count {
                
                imageIndex = 0
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
               
                changeBanner()
            }
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        setSegmentsTitle()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 每 3 秒呼叫一次 changeBanner()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(changeBanner), userInfo: nil, repeats: true)
    }

    
    // 飲料選單點選
    @IBAction func changeMenu(_ sender: UISegmentedControl) {
        
        for containerView in containerViews {
              containerView.isHidden = true
           }
           containerViews[sender.selectedSegmentIndex].isHidden = false
    }
    
    
    // 飲料分類名字
    func setSegmentsTitle() {
        
        drinkSegments.setTitle("\(genreList.找好茶)", forSegmentAt: 0)
        drinkSegments.setTitle("\(genreList.找新鮮)", forSegmentAt: 1)
        drinkSegments.setTitle("\(genreList.找奶茶)", forSegmentAt: 2)
        drinkSegments.setTitle("\(genreList.找拿鐵)", forSegmentAt: 3)
    }
}
