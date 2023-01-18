//
//  PokemonTestTests.swift
//  PokemonTestTests
//
//  Created by 劉柏賢 on 2023/1/18.
//

import XCTest

@testable import PokemonTest

final class PokemonTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// PokemonListWebAPI
    func testPokemonListWebAPI() async throws {
        let parameter = PokemonListParameter(limit: 10, offset: 0)
        let model = try await PokemonListWebAPI().invokeAsync(parameter)
        XCTAssertTrue(!model.results.isEmpty)
        XCTAssertTrue(!model.next.isEmpty)
    }
    
    /// PokemonDetailWebAPI
    func testPokemonDetailWebAPI() async throws {
        let parameter = PokemonDetailParameter()
        let model = try await PokemonDetailWebAPI(urlString: "https://pokeapi.co/api/v2/pokemon/1/").invokeAsync(parameter)
        XCTAssertTrue(model.id != .zero)
        XCTAssertTrue(!model.sprites.frontDefault.isEmpty)
        XCTAssertTrue(model.height != .zero)
        XCTAssertTrue(model.weight != .zero)
        XCTAssertTrue(!model.types.isEmpty)
        
        model.types.forEach { (item: PokemonDetailModel.Types) in
            XCTAssertTrue(!item.type.name.isEmpty)
        }
    }
}
