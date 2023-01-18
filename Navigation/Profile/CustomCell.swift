//
//  CustomCell.swift
//  Navigation
//
// Ячейка в коллекцию на главный экран (4 фото)
//

import UIKit

class CustomCell: UICollectionViewCell {
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
    
    
    func setup(with viewModel: ViewModel) {
        self.imageForCell.image = viewModel.image
    }
    
    private func setupView(){
        self.contentView.addSubview(self.imageForCell)
        
        NSLayoutConstraint.activate([
            self.imageForCell.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageForCell.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.imageForCell.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.imageForCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
