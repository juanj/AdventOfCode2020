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
                return ImageFragment(id: id, data: data, neighbors: [])
            }
    }

    public func findNeighbors(images: [ImageFragment]) -> [ImageFragment] {
        var images = images
        
        for (index, image) in images.enumerated() {
            for possibleNeighbor in images where possibleNeighbor.id != image.id {
                if possibleNeighbor.adjacentBorder(image.topBorder) != nil ||
                    possibleNeighbor.adjacentBorder(image.bottomBorder) != nil ||
                    possibleNeighbor.adjacentBorder(image.leftBorder) != nil ||
                    possibleNeighbor.adjacentBorder(image.rightBorder) != nil {
                    images[index].neighbors.append(possibleNeighbor)
                }
            }
        }

        return images
    }

    public func buildFullImage(fragments: [ImageFragment]) -> [[Int]] {
        var fullImage = [[Int]]()
        let size = Int(sqrt(Double(fragments.count)))
        var image = [[ImageFragment]]()

        var borders = fragments.filter { $0.neighbors.count == 3 }
        var corners = fragments.filter { $0.neighbors.count == 2 }
        let content = fragments.filter { $0.neighbors.count == 4 }

        var previousRow = [corners.popLast()!]

        // TODO: Clean this
        // Create first border
        borderLoop: while previousRow.count != size {
            for (index, var border) in borders.enumerated() {
                if previousRow.last?.isInNeighbors(id: border.id) == true, var sides = previousRow.last!.getMachingSide(border) {
                    if sides.hisSide == .bottomReverse || sides.hisSide == .top {
                        sides.hisSide = sides.hisSide == .bottomReverse ? .bottom : .topReverse
                        border.data = border.data.map { $0.reversed() }
                    }
                    if sides.hisSide == .leftReverse || sides.hisSide == .right {
                        sides.hisSide = sides.hisSide == .leftReverse ? .left : .rightReverse
                        border.data = border.data.reversed()
                    }
                    if sides.hisSide != .left {
                        if sides.hisSide == .topReverse {
                            border.rotateData(times: 3)
                        } else if sides.hisSide == .rightReverse {
                            border.rotateData(times: 2)
                        } else if sides.hisSide == .bottom {
                            border.rotateData(times: 1)
                        }
                    }
                    if previousRow.count == 1 && sides.mySide != .right {
                        if sides.mySide == .left {
                            previousRow[0].data = previousRow[0].data.reversed()
                            previousRow[0].rotateData(times: 2)
                        } else if sides.mySide == .leftReverse {
                            previousRow[0].rotateData(times: 2)
                        } else if sides.mySide == .top {
                            previousRow[0].rotateData(times: 1)
                        } else if sides.mySide == .bottom {
                            previousRow[0].data = previousRow[0].data.map { $0.reversed() }
                            previousRow[0].rotateData(times: 3)
                        }
                    }
                    previousRow.append(border)
                    borders.remove(at: index)
                    if previousRow.count == size - 1,
                       let cornerIndex = corners.firstIndex(where: { border.isInNeighbors(id: $0.id) }),
                       var sides = border.getMachingSide(corners[cornerIndex]) {
                        var corner = corners[cornerIndex]
                        if sides.hisSide != .left {
                            if sides.hisSide == .bottomReverse || sides.hisSide == .top {
                                sides.hisSide = sides.hisSide == .bottomReverse ? .bottom : .topReverse
                                corner.data = corner.data.map { $0.reversed() }
                            }
                            if sides.hisSide == .leftReverse || sides.hisSide == .right {
                                sides.hisSide = sides.hisSide == .leftReverse ? .left : .rightReverse
                                corner.data = corner.data.reversed()
                            }
                            if sides.hisSide == .topReverse {
                                corner.rotateData(times: 3)
                            } else if sides.hisSide == .rightReverse {
                                corner.rotateData(times: 2)
                            } else if sides.hisSide == .bottom {
                                corner.rotateData(times: 1)
                            }
                        }
                        previousRow.append(corner)
                        corners.remove(at: cornerIndex)
                    }
                    continue borderLoop
                }
            }
        }
        image.append(previousRow)
        var allFragments = borders + corners + content

        for _ in 1..<size {
            var nextRow = [ImageFragment]()
            let firstIndex = allFragments.firstIndex(where: { previousRow[0].isInNeighbors(id: $0.id) })!
            nextRow.append(allFragments[firstIndex])
            allFragments.remove(at: firstIndex)
            rowLoop: while nextRow.count != size {
                for (index, var otherFragment) in allFragments.enumerated() {
                    if nextRow.last?.isInNeighbors(id: otherFragment.id) == true, previousRow[nextRow.count].isInNeighbors(id: otherFragment.id), var sides = nextRow.last!.getMachingSide(otherFragment) {
                        if sides.hisSide == .bottomReverse || sides.hisSide == .top {
                            sides.hisSide = sides.hisSide == .bottomReverse ? .bottom : .topReverse
                            otherFragment.data = otherFragment.data.map { $0.reversed() }
                        }
                        if sides.hisSide == .leftReverse || sides.hisSide == .right {
                            sides.hisSide = sides.hisSide == .leftReverse ? .left : .rightReverse
                            otherFragment.data = otherFragment.data.reversed()
                        }
                        if sides.hisSide != .left {
                            if sides.hisSide == .topReverse {
                                otherFragment.rotateData(times: 3)
                            } else if sides.hisSide == .rightReverse {
                                otherFragment.rotateData(times: 2)
                            } else if sides.hisSide == .bottom {
                                otherFragment.rotateData(times: 1)
                            }
                        }
                        if nextRow.count == 1 && sides.mySide != .right {
                            if sides.mySide == .left {
                                nextRow[0].data = nextRow[0].data.reversed()
                                nextRow[0].rotateData(times: 2)
                            } else if sides.mySide == .leftReverse {
                                nextRow[0].rotateData(times: 2)
                            } else if sides.mySide == .top {
                                nextRow[0].rotateData(times: 1)
                            } else if sides.mySide == .bottom {
                                nextRow[0].data = nextRow[0].data.map { $0.reversed() }
                                nextRow[0].rotateData(times: 3)
                            }
                        }
                        nextRow.append(otherFragment)
                        allFragments.remove(at: index)
                        continue rowLoop
                    }
                }
            }
            image.append(nextRow)
            previousRow = nextRow
        }

        // Flip rows
        for row in 0..<(image.count - 1) {
            if let sides = image[row][0].getMachingSide(image[row + 1][0]), sides.mySide != .bottom {
                for column in 0..<image[row].count {
                    image[row][column].data = image[row][column].data.reversed()
                }
            }
        }


        // Construct full image
        for (rowIndex, row) in image.enumerated() {
            fullImage.append(contentsOf: Array(repeating: [], count: row[0].data.count - 2))
            for column in row {
                for (dataIndex, dataRow) in column.data.enumerated() where dataIndex != 0 && dataIndex != dataRow.count - 1 {
                    fullImage[rowIndex * (row[0].data.count - 2) + dataIndex - 1] += dataRow.dropLast().dropFirst()
                }
            }
        }
        return fullImage
    }
}
