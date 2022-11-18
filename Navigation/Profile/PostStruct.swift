//
//  PostStruct.swift
//  Navigation
//
//  Created by JaY on 11.11.2022.
//

import UIKit

struct PostStruct {
    var author: String
    var description: String
    var image: UIImage?
    var likes: String
    var views: String
}

// MARK: создание постов для публикации

var post1 = PostStruct(author: "Sainchuk Nikolay", description: "Фотографию сделал прогуливаясь по ВДНХ. #вднх #лабиринт #moscow #Москва", image: UIImage(named: "photo"), likes: "Likes: 45 ", views: "Views: 5 ")

var post2 = PostStruct(author: "Swift.school", description:  "Приглашаем в нашу школу по изучению разработки мобильных приложений на языке программирования Swift", image: UIImage(named: "swift"), likes: "Likes: 45 ", views: "Views: 5 ")

var post3 = PostStruct(author: "Apple.fanclub", description: "WWDC 2022 пройдёт с 6 по 10 июня 2022г. На ней представят новые iOS, iPadOS, macOS и tvOS. Церемония открытия конференции для разработчиков  WWDC 2022 пройдет 6 июня.  На ней традиционно показывают новые версии операционных систем Apple, а также иногда представляют новые продукты.", image: UIImage(named: "wwdc22"), likes: "Likes: 4500 ", views: "Views: 5924 ")

var post4 = PostStruct(author: "Assasins.Creed", description: "Предстоящая видеоигра в жанре Action-Adventure, разрабатываемая студией Ubisoft Bordeaux и изданная Ubisoft. Является тринадцатой крупной частью серии Assassin’s Creed и преемником игры Assassin’s Creed Valhalla. Действия игры будут происходить в Багдаде в девятом веке, а игрок управляет Басимом ибн Исхаком, вором, который затем становится мастером-ассасином в Братстве ассасинов, которые борются за мир и свободу против Ордена тамплиеров, стремящихся к миру через контроль. Ранее появлялся в Assassin’s Creed Valhalla. Игра является похожей на первую часть серии Assassin’s Creed, и по описанию, в ней основное внимание уделяется стелсу, паркуру и убийствам.", image: UIImage(named: "assasins"), likes: "Likes: 600 ", views: "Views: 987 ")


