//
//  MatchesCollectionModel.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 09/10/2023.
//

import Foundation

public struct Matches: Codable {
    public let d: String
    public let i: String
    public let si: String
    public let sh: String
    public let tt: Int
    public var isSelected: Bool?
}
