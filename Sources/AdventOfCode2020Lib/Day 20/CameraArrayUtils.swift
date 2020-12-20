//
//  CameraArrayUtils.swift
//  
//
//  Created by Juan on 20/12/20.
//

import Foundation

public struct CameraArrayUtils {
    public init() {}
    public func load(from file: String) -> [ImageFragment] {
        file.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map { data -> ImageFragment in
                let lines = data.components(separatedBy: .newlines)
                let id = Int(lines[0].components(separatedBy: " ")[1].dropLast()) ?? 0
                let data = lines
                    .dropFirst()
                    .map { $0.map { $0 == "#" ? 1 : 0 } }
                return ImageFragment(id: id, data: data, neigbors: [])
            }
    }

    public func findNeighbors(images: [ImageFragment]) -> [ImageFragment] {
        var images = images
        
        for (index, image) in images.enumerated() {
            if image.id == 2311 {
                print(1)
            }
            for possibleNeighbor in images where possibleNeighbor.id != image.id {
                if possibleNeighbor.hasBorder(image.topBorder) ||
                    possibleNeighbor.hasBorder(image.bottomBorder) ||
                    possibleNeighbor.hasBorder(image.leftBorder) ||
                    possibleNeighbor.hasBorder(image.rightBorder) {
                    images[index].neigbors.append(possibleNeighbor.id)
                }
            }
        }

        return images
    }
}
