//
//  PostViewController.swift
//  Navigation
//
//  Post
//

import UIKit
import AVFoundation



class PostViewController: UIViewController {
    
    // MARK: - Properties
    private let post = Post(title: "Music")
    private var audioPlayer: AVAudioPlayer?
    var track = ["System_of_a_Down-Chop_Suey", "Slipknot-Psychosocial", "Nirvana-Smells_Like_Teen_Spirit", "Bon_Jovi-Its_My_Life", "Korn_-_Freak_On_a_Leash"]
    var current = 0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Post Title"
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
// Стэк кнопок
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
 // Обложка трека
    private lazy var coverImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = UIImage(named: "song")
        image.contentMode = .scaleAspectFit
        return image
    }()
// Название трека
    private lazy var nameSong: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        return label
    }()
// Кнопка play
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        button.addTarget(self, action: #selector(pressPlay), for: .touchUpInside)
        return button
    }()
// Кнопка stop
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        button.addTarget(self, action: #selector(pressStop), for: .touchUpInside)
        return button
    }()
// Кнопка next track
    private lazy var nextTrack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        button.addTarget(self, action: #selector(pressNext), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        playAudio()
    }
    
    // MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .systemGray6
        setupBarButtonItem()
        titleLabel.text = post.title
        setupConstraints()
    }
    
    func setupBarButtonItem() {
        let barItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(addTarget))
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(coverImage)
        view.addSubview(nameSong)
        view.addSubview(stackView)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(nextTrack)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coverImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            coverImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameSong.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 20),
            nameSong.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameSong.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: nameSong.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                
            
            
        ])
    }
    
    private func playAudio() {
        do {
            guard let fileURL = Bundle.main.url(forResource: self.track[self.current], withExtension: "mp3")
                  
            else {
                return
            }
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
       
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: AVFileType.mp3.rawValue)
            
            audioPlayer?.prepareToPlay()
            
        }
        catch {
            print(error.localizedDescription)
            return
        }

    }
    
    @objc func pressPlay() {
       
        if audioPlayer?.isPlaying == true {
            self.audioPlayer?.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }else {
            audioPlayer?.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)}
        nameSong.text = audioPlayer?.url?.lastPathComponent
        
    }
    
    @objc func pressStop() {

        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        current = 0
        
    }
    
  
    
    @objc func pressNext() {
        if track.count - 1 != current {
            current += 1

        }else {
            current = 0
        }
        
        do {
            guard let fileURL = Bundle.main.url(forResource: self.track[self.current], withExtension: "mp3")
                  
            else {
                return
            }
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: AVFileType.mp3.rawValue)
            
            
            audioPlayer?.play()
            
        }
        catch {
            print(error.localizedDescription)
            return
        }
        nameSong.text = audioPlayer?.url?.lastPathComponent
    }
    
    deinit {
        
    }
    
    @objc func addTarget() {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
}

