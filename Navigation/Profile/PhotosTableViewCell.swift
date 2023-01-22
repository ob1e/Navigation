//
//  PhotosTableViewCell.swift
//  Navigation

//Ячейка на главный экран с отображением первых 4 фоток

import UIKit


class PhotosTableViewCell: UITableViewCell {


    private enum Constants {
        static let numberOfItemsinLine: CGFloat = 4
    }
    
    let size = (UIScreen.main.bounds.width - 60)/4

    let viewModel: [UIImage] = [ UIImage(named: "dog1")!, UIImage(named: "dog2")!, UIImage(named: "dog3")!, UIImage(named: "dog4")!, UIImage(named: "dog5")!]
    
    private lazy var labelPhoto: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    private lazy var arrowRight: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
       return image
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.estimatedItemSize = .zero
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true //пролистывание элементов
        collection.alwaysBounceHorizontal = true // отскок при прокручивании
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(labelPhoto)
        self.contentView.addSubview(arrowRight)
    }
    

    func setupUI () {
        self.collectionView.reloadData()
        
        NSLayoutConstraint.activate([
            
            labelPhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            //            labelPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
            labelPhoto.heightAnchor.constraint(equalToConstant: 30),
            
            arrowRight.topAnchor.constraint(equalTo: contentView.topAnchor),
            arrowRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowRight.heightAnchor.constraint(equalToConstant: 30),
            arrowRight.widthAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: size + 24)
            
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for:  indexPath) as? CustomCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        
        let item = self.viewModel[indexPath.item]
        let viewModel = CustomCell.ViewModel(image: item).self
        cell.setup(with: viewModel)
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout{
    private var inSpace: CGFloat { return 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inSpace, left: inSpace, bottom: inSpace, right: inSpace)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: size, height: size)
    }
}
