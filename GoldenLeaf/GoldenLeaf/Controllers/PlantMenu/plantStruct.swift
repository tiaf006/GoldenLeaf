// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let plant = try? JSONDecoder().decode(Plant.self, from: jsonData)

import Foundation

// MARK: - PlantElement
struct PlantElement: Codable {
    let latinName: String?
    let style: String?
    let lightTolered: LightTolered?
    let heightAtPurchase: HeightAtPurchase?
    let lightIdeal: LightIdeal?
    let widthAtPurchase: HeightAtPurchase?
    let img: String?
    let perfume: String?
    let growth: Growth?
    let widthPotential: HeightAtPurchase?
    let commonNameFr: String?
    let heightPotential: HeightAtPurchase?
    let temperatureMax: TemperatureMax?
    let bloomingSeason: String?
    let colorOfLeaf: [String]?
    let watering: String?
    let colorOfBlooms: String?
    let commonName: [String]?
    let description: JSONNull?
    let bearing: String?
    
    enum CodingKeys: String, CodingKey {
        case latinName = "Latin name"
        case style = "Style"
        case lightTolered = "Light tolered"
        case heightAtPurchase = "Height at purchase"
        case lightIdeal = "Light ideal"
        case widthAtPurchase = "Width at purchase"
        case img
        case perfume = "Perfume"
        case growth = "Growth"
        case widthPotential = "Width potential"
        case commonNameFr = "Common name (fr.)"
        case heightPotential = "Height potential"
        case temperatureMax = "Temperature max"
        case bloomingSeason = "Blooming season"
        case colorOfLeaf = "Color of leaf"
        case watering = "Watering"
        case colorOfBlooms = "Color of blooms"
        case commonName = "Common name"
        case description = "Description"
        case bearing = "Bearing"
    }
}

enum Growth: String, Codable {
    case fast = "Fast"
    case regular = "Regular"
    case slow = "Slow"
    case verySlow = "Very slow"
}

// MARK: - HeightAtPurchase
struct HeightAtPurchase: Codable {
    let m: Double?
    let cm: Int?
}

enum LightIdeal: String, Codable {
    case fullSun21500Lux2000Fc = "Full sun (+21,500 lux /+2000 fc )"
    case strongLight21500To3200Lux2000To300Fc = "Strong light ( 21,500 to 3,200 lux/2000 to 300 fc)"
}

enum LightTolered: String, Codable {
    case diffuseLightLessThan5300Lux500Fc = "Diffuse light ( Less than 5,300 lux / 500 fc)"
    case strongLight21500To3200Lux2000To300Fc = "Strong light ( 21,500 to 3,200 lux/2000 to 300 fc)"
}

// MARK: - TemperatureMax
struct TemperatureMax: Codable {
    let f: Double?
    let c: Int?

    enum CodingKeys: String, CodingKey {
        case f = "F"
        case c = "C"
    }
}

typealias Plant = [PlantElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

