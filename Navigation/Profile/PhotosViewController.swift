//
//  PhotosViewController.swift
//  Navigation
// Коллекция фотографии

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    // MARK: - Properties
    
//    var imagePublisher = ImagePublisherFacade()
   
    var viewModel: [UIImage] = [] //пустой массив для фотогаллереи
    var imageProcessor = ImageProcessor()
    var photoArray = PhotoGallery().photosArray //массив с фотографиями для галлереи
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
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
        DispatchQueue.main.async {
            self.imageProcessorBackground()
//            self.imageProcessorDefault()
//            self.imageProcessorUserInit()
//            self.imageProcessorUserInteracrive()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute:{
            self.collectionView.reloadData()
        })
    }
    
//MARK: - Methods

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false // большой заголовок
        navigationItem.title = "Photo Gallery"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func imageProcessorBackground() {
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photoArray, filter: .chrome, qos: .background) { image in
            for items in image {
                self.viewModel.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nano = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nano) / 1000000000
            print("Execution time background \(timeInterval)")
        }
    }
    
    func imageProcessorDefault() {
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photoArray, filter: .colorInvert, qos: .default) { image in
            for items in image {
                self.viewModel.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nano = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nano) / 1000000000
            print("Execution time default \(timeInterval)")
        }
    }
    
    func imageProcessorUserInit() {
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photoArray, filter: .fade, qos: .userInitiated) { image in
            for items in image {
                self.viewModel.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nano = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nano) / 1000000000
            print("Execution time userInitiated \(timeInterval)")
        }
    }
    
    func imageProcessorUserInteracrive() {
        let start = DispatchTime.now()
        self.imageProcessor.processImagesOnThread(sourceImages: photoArray, filter: .noir, qos: .userInteractive) { image in
            for items in image {
                self.viewModel.append(UIImage(cgImage: items!))
            }
            let end = DispatchTime.now()
            let nano = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nano) / 1000000000
            print("Execution time userInteractive \(timeInterval)")
        }
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        imagePublisher.removeSubscription(for: self)
//    }
    
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

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        viewModel = images
        collectionView.reloadData()
    }
}
