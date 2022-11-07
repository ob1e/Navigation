//
//  CustomButton.swift
//  Navigation
//
//  Created by JaY on 30.10.2022.
//

import UIKit

//MARK: кастомная кнопка с изменением альфа-канала для разных её состояний
class CustomButton: UIButton {
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
}

