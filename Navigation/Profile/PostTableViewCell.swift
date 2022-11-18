//
//  CustomTableViewCell.swift
//  Navigation


import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var author: String
        var description: String
        var image: UIImage?
        var likes: String
        var views: String
        let indexPath: IndexPath
    }
    
    private lazy var authorPost: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descriptionPost: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var imagePost: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
        
    private lazy var likesPost: UILabel = {
        let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.systemFont(ofSize: 16 , weight: .regular)
        likes.textColor = .black
        return likes
    }()

    private lazy var viewsPost: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16 , weight: .regular)
        view.textColor = .black
        return view
    }()
    
    private var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.indexPath = nil
        self.authorPost.text = nil
        self.descriptionPost.text = nil
        self.imagePost.image = nil
        self.likesPost.text = nil
        self.viewsPost.text = nil
    }
    
    func setup(with viewModel: ViewModel) {
        self.indexPath = viewModel.indexPath
        self.authorPost.text = viewModel.author
        self.descriptionPost.text = viewModel.description
        self.imagePost.image = viewModel.image
        self.likesPost.text = viewModel.likes
        self.viewsPost.text = viewModel.views
    }
    
    func setupUI() {
        self.contentView.addSubview(self.authorPost)
        self.contentView.addSubview(self.imagePost)
        self.contentView.addSubview(self.descriptionPost)
        self.contentView.addSubview(self.likesPost)
        self.contentView.addSubview(self.viewsPost)
        
        NSLayoutConstraint.activate([
            
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.authorPost.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorPost.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),

            self.imagePost.topAnchor.constraint(equalTo: self.authorPost.bottomAnchor),
            self.imagePost.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imagePost.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imagePost.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.imagePost.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.imagePost.heightAnchor.constraint(equalTo: imagePost.widthAnchor),
            
            self.descriptionPost.topAnchor.constraint(equalTo: self.imagePost.bottomAnchor, constant: 16),
            self.descriptionPost.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionPost.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.likesPost.topAnchor.constraint(equalTo: self.descriptionPost.bottomAnchor, constant: 16),
            self.likesPost.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.likesPost.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),

            self.viewsPost.topAnchor.constraint(equalTo: self.descriptionPost.bottomAnchor, constant: 16),
            self.viewsPost.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.viewsPost.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
            
        ])
    }
    
}

