//
//  PhotosCollectionViewCell.swift
//  Navigation
//
// Ячейка для коллекции фотогалереи

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel {
        var image: UIImage?
    }
    
    private var imageForCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(with image: ViewModel) {
        self.imageForCell.image = image.image
    }
    
    private func setupView(){
        self.addSubview(self.imageForCell)
        
        NSLayoutConstraint.activate([
            self.imageForCell.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageForCell.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageForCell.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.imageForCell.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
