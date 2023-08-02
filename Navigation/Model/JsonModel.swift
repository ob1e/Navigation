//
//  JsonModel.swift
//  Navigation
// модели JSON  для парсинга


import Foundation

struct UserInfo {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

struct PlanetsInfo: Decodable {
    var name: String
    var rotation_period:String
    var orbital_period: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
}
