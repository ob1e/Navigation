//
//  ProfileViewController.swift
//  Navigation
// Главный экран профиль стена

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    

    private lazy var  tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 100
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCellID")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(ProfileTableHederView.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderFooterViewID")
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()

    private var viewModel: [PostStruct] = [post1, post2, post3, post4]
    
    let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
#if DEBUG
        self.tableView.backgroundColor = .systemGray
#else
        self.tableView.backgroundColor = .white
#endif
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        //Timer
        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
            self.showAlert()
        })
        
    }
    
    // MARK: - Methods

    func setupUI() {
        setupConstraint()
    }
    
    func setupConstraint() {
        self.view.addSubview(tableView)
       
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
// Alert for timer
     private func showAlert() {
        let alert = UIAlertController(title: "Вышло обновление приложения.", message: "Обновите приложение чтобы воспользоваться актуальными функциями", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: Extension

extension ProfileViewController: UITableViewDataSource {
    //    Расчет размера ячейки в разных секциях
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var  x: CGFloat = 0
        if indexPath.section == 0 {
            x = (UIScreen.main.bounds.width - 60) / 4 + 24 + 30
        } else {
            x = UITableView.automaticDimension
        }
        return x
    }
    
    // количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.viewModel.count
        }
        return 1
    }
    // добавление ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            return cell
        }
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCellID", for: indexPath) as? PostTableViewCell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        if indexPath.section == 1 {
            let post = self.viewModel[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views, indexPath: indexPath)
            cell.setup(with: viewModel)
            return cell
        }
        return cell
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderFooterViewID") as? ProfileTableHederView
            else {
                return nil
            }
            view.fullNameLabel.text = user.fullName
            view.avatarImageView.image = user.avatar
            view.statusLabel.text = user.status
            return view
        }
        return nil
    }
    
//    Выделение ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let photoGallery = PhotosViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            navigationController?.pushViewController(photoGallery, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
        
    }
}
