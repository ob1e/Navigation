//
//  PhotosViewController.swift
//  Navigation
// Коллекция фотографии

import UIKit

class PhotosViewController: UIViewController {
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
    let viewModel: [UIImage] = [ UIImage(named: "dog1")!, UIImage(named: "dog2")!, UIImage(named: "dog3")!, UIImage(named: "dog4")!, UIImage(named: "dog5")!, UIImage(named: "dog6")!, UIImage(named: "dog7")!, UIImage(named: "dog8")!, UIImage(named: "dog9")!, UIImage(named: "dog10")!, UIImage(named: "dog11")!, UIImage(named: "dog12")!, UIImage(named: "dog14")!, UIImage(named: "dog15")!, UIImage(named: "dog16")!, UIImage(named: "dog18")!, UIImage(named: "dog19")!, UIImage(named: "dog20")!, UIImage(named: "dog21")!, UIImage(named: "dog22")! ]
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.estimatedItemSize = .zero
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false // большой заголовок
        navigationItem.title = "Photo Gallery"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

//    MARK: Extension

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for:  indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.clipsToBounds = true
        
        let item = self.viewModel[indexPath.item]
        let viewModel = PhotosCollectionViewCell.ViewModel(image: item).self
        cell.setup(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        
        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / Constants.numberOfItemsInLine)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
