import XCTest
@testable import AdventOfCode2020Lib

final class EnergySourceUtilsTests: XCTestCase {
    func testNeighborsOn_testDataCenter_returns5() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)
        let emptyLayer = Array(repeating: Array(repeating: 0, count: 3), count: 3)

        let neighbors = utils.neighborsOn(state: [emptyLayer, firstLayer, emptyLayer], point: (x: 1, y: 1, z: 1))

        XCTAssertEqual(neighbors, 5)
    }

    func testNeighborsOn_testDataTopCorner_returns1() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)
        let emptyLayer = Array(repeating: Array(repeating: 0, count: 3), count: 3)

        let neighbors = utils.neighborsOn(state: [emptyLayer, firstLayer, emptyLayer], point: (x: 0, y: 0, z: 1))

        XCTAssertEqual(neighbors, 1)
    }

    func testNeighborsOn_testDataCenterLayer0_returns5() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)
        let emptyLayer = Array(repeating: Array(repeating: 0, count: 3), count: 3)

        let neighbors = utils.neighborsOn(state: [emptyLayer, firstLayer, emptyLayer], point: (x: 1, y: 1, z: 0))

        XCTAssertEqual(neighbors, 5)
    }

    func testFacesNeeded_testDataMiddleLayer_returnsFaces() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)
        let emptyLayer = Array(repeating: Array(repeating: 0, count: 3), count: 3)

        let faces = utils.facesNeeded(state: [emptyLayer, firstLayer, emptyLayer])

        XCTAssertEqual(faces, [.left, .right, .back, .front])
    }

    func testFacesNeeded_testDataBottomLayer_returnsFaces() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)
        let emptyLayer = Array(repeating: Array(repeating: 0, count: 3), count: 3)

        let faces = utils.facesNeeded(state: [firstLayer, emptyLayer])

        XCTAssertEqual(faces, [.left, .right, .back, .front, .bottom])
    }

    func testFacesNeeded_testDataTopLayer_returnsFaces() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)
        let emptyLayer = Array(repeating: Array(repeating: 0, count: 3), count: 3)

        let faces = utils.facesNeeded(state: [emptyLayer, firstLayer])

        XCTAssertEqual(faces, [.left, .right, .back, .front, .top])
    }

    func testFacesNeeded_testDataAlone_returnsFaces() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)

        let faces = utils.facesNeeded(state: [firstLayer])

        XCTAssertEqual(faces, [.left, .right, .back, .front, .top, .bottom])
    }

    func testFacesNeeded_zero_returnsFaces() {
        let input = """
        ...
        ...
        ...
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)

        let faces = utils.facesNeeded(state: [firstLayer])

        XCTAssertEqual(faces, [])
    }

    func testAddFaces_leftFace_addsLeftFace() {
        let state = [
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.left])

        XCTAssertEqual(newState, [
            [
                [0, 1, 1],
                [0, 1, 1],
                [0, 1, 1]
            ],
            [
                [0, 1, 1],
                [0, 1, 1],
                [0, 1, 1]
            ]
        ])
    }

    func testAddFaces_rightFace_addsRightFace() {
        let state = [
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.right])

        XCTAssertEqual(newState, [
            [
                [1, 1, 0],
                [1, 1, 0],
                [1, 1, 0]
            ],
            [
                [1, 1, 0],
                [1, 1, 0],
                [1, 1, 0]
            ]
        ])
    }

    func testAddFaces_bottomFace_addsBottomFace() {
        let state = [
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.bottom])

        XCTAssertEqual(newState, [
            [
                [0, 0],
                [0, 0],
                [0, 0]
            ],
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1],
                [1, 1]
            ]
        ])
    }

    func testAddFaces_topFace_addsTopFace() {
        let state = [
            [
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.top])

        XCTAssertEqual(newState, [
            [
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1]
            ],
            [
                [0, 0],
                [0, 0]
            ]
        ])
    }

    func testAddFaces_frontFace_addsFrontFace() {
        let state = [
            [
                [1, 1, 1],
                [1, 1, 1]
            ],
            [
                [1, 1, 1],
                [1, 1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.front])

        XCTAssertEqual(newState, [
            [
                [1, 1, 1],
                [1, 1, 1],
                [0, 0, 0]
            ],
            [
                [1, 1, 1],
                [1, 1, 1],
                [0, 0, 0]
            ]
        ])
    }

    func testAddFaces_backFace_addsBackFace() {
        let state = [
            [
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.back])

        XCTAssertEqual(newState, [
            [
                [0, 0],
                [1, 1],
                [1, 1]
            ],
            [
                [0, 0],
                [1, 1],
                [1, 1]
            ]
        ])
    }

    func testAddFaces_allFaces_addsAllFaces() {
        let state = [
            [
                [1, 1],
                [1, 1]
            ],
            [
                [1, 1],
                [1, 1]
            ]
        ]
        let utils = EnergySourceUtils()

        let newState = utils.addFaces(state: state, sides: [.top, .bottom, .right, .left, .front, .back])

        XCTAssertEqual(newState, [
            [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ],
            [
                [0, 0, 0, 0],
                [0, 1, 1, 0],
                [0, 1, 1, 0],
                [0, 0, 0, 0]
            ],
            [
                [0, 0, 0, 0],
                [0, 1, 1, 0],
                [0, 1, 1, 0],
                [0, 0, 0, 0]
            ],
            [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ],
        ])
    }


    func testStep_testDataOneStep_returnsCorrectMiddleLayer() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)

        let newState = utils.step(state: [firstLayer])

        XCTAssertEqual(newState[1], [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 1, 0, 1, 0],
            [0, 0, 1, 1, 0],
            [0, 0, 1, 0, 0]
        ])
    }

    func testStep_testDataSixSteps_returnsNumberOfOn() {
        let input = """
        .#.
        ..#
        ###
        """
        let utils = EnergySourceUtils()
        let firstLayer = utils.load(from: input)

        var newState = utils.step(state: [firstLayer])
        newState = utils.step(state: newState)
        newState = utils.step(state: newState)
        newState = utils.step(state: newState)
        newState = utils.step(state: newState)
        newState = utils.step(state: newState)

        XCTAssertEqual(newState.reduce(0, { $0 + $1.reduce(0, { $0 + $1.reduce(0, +)}) }), 112)
    }
}
