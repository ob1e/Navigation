//
//  ButtonModel.swift
//  Navigation
//
//  Created by JaY on 10.04.2023.
//

import UIKit

class CustomButton: UIButton {
    var buttonTapped:(()->Void)?
    
    override init(frame: CGRect){
        super .init(frame: frame)
    }
    
    init (title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!)
        imageView?.contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(tappet), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    
    @objc private func tappet(){
        buttonTapped?()
    }
    
}



